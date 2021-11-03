package com.stagereserve.controllers;

import com.stagereserve.forms.StageForm;
import com.stagereserve.models.Reservation;
import com.stagereserve.models.Stage;
import com.stagereserve.models.User;
import com.stagereserve.services.MailService;
import com.stagereserve.services.ReservationService;
import com.stagereserve.services.StageService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.logging.Logger;

@Controller
public class StagesManagementController {

    private static final Logger logger = Logger.getLogger(StagesManagementController.class.getName());
    private final String STATIC_FOLDER_PATH = "WEB-INF/resources/images/stages/";

    @Autowired
    private StageService stageService;

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private MailService mailService;

    @Autowired
    private ServletContext context;

    // This method creates the stagesManagement page view, accessible by users with the appropriate right.
    @GetMapping(value="/stagesManagement")
    public ModelAndView getManagement(HttpServletRequest request) {
        try {
            // Session existence check.
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            // User right check.
            if (!user.getManagement()) {
                return new ModelAndView("redirect:/notFound");
            }
            // View creation.
            List<Stage> stages = stageService.findAll();
            ModelAndView mav = new ModelAndView("stagesManagement");
            mav.addObject("user", user);
            mav.addObject("stages", stages);
            mav.addObject("stageForm", new StageForm());
            return mav;
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    // This method enables users with appropriate right to create a new stage.
    @PostMapping(value="/stagesManagement")
    public ModelAndView addStage(HttpServletRequest request, @Valid @ModelAttribute StageForm stageForm) {
        try {
            // Session existence check.
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            // User right check.
            if (!user.getManagement()) {
                return new ModelAndView("redirect:/notFound");
            }
            // Stage creation.
            Stage stage = new Stage();
            stage.setName(stageForm.getName());
            stage.setDescription(stageForm.getDescription());
            stage.setActive((stageForm.getActive() != null) ? stageForm.getActive() : false);
            stage.setCapacity(stageForm.getCapacity());
            stage.setImage(stageForm.getFile().getOriginalFilename());
            stage = stageService.save(stage);
            // Stage static image creation.
            String stageFolderPath = context.getRealPath(STATIC_FOLDER_PATH) + stage.getId();
            File stageFolder = new File(stageFolderPath);
            if (stageFolder.exists()) {
                FileUtils.forceDelete(stageFolder);
            }
            Files.createDirectories(Paths.get(stageFolderPath));
            stageFolderPath += File.separator;
            stageForm.getFile().transferTo(new File(stageFolderPath + stageForm.getFile().getOriginalFilename()));
            return new ModelAndView("redirect:/stagesManagement");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    // This method enables users with appropriate right to edit the information of a stage.
    @PostMapping(value="/stagesManagement/{id}")
    public ModelAndView editStage(HttpServletRequest request, @PathVariable Integer id, @Valid @ModelAttribute StageForm stageForm) {
        try {
            // Session existence check.
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            // User right check.
            if (!user.getManagement()) {
                return new ModelAndView("redirect:/notFound");
            }
            // Stage existence check.
            Stage stage = stageService.findStageById(id);
            if (stage == null) {
                return new ModelAndView("redirect:/notFound");
            }
            // Edit execution.
            stage.setName(stageForm.getName());
            stage.setDescription(stageForm.getDescription());
            stage.setActive((stageForm.getActive() != null) ? stageForm.getActive() : false);
            stage.setCapacity(stageForm.getCapacity());
            if (stageForm.getFile() != null && !stageForm.getFile().isEmpty()) {
                // Stage static image update.
                stage.setImage(stageForm.getFile().getOriginalFilename());
                String stageFolderPath = context.getRealPath(STATIC_FOLDER_PATH) + stage.getId();
                File stageFolder = new File(stageFolderPath);
                if (stageFolder.exists()) {
                    FileUtils.forceDelete(stageFolder);
                }
                Files.createDirectories(Paths.get(stageFolderPath));
                stageFolderPath += File.separator;
                stageForm.getFile().transferTo(new File(stageFolderPath + stageForm.getFile().getOriginalFilename()));
            }
            stageService.save(stage);
            if (!stage.getActive()) {
                List<Reservation> activeReservations = reservationService.findStageActiveReservations(stage.getId());
                for (Reservation activeReservation : activeReservations) {
                    mailService.sendEmail("Stage reservation cancelled!",
                            activeReservation.getCreatedBy().getEmail(),
                            "We are sorry to inform you that your reservation <b>" + activeReservation.getId()
                                    + "</b> for event <b>" + activeReservation.getEvent()
                                    + "</b> has been cancelled, as stage <b>" + activeReservation.getStage().getName() + "</b> is no longer available.");
                    reservationService.delete(activeReservation);
                }
            }
            return new ModelAndView("redirect:/stagesManagement");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    // This method enables users with appropriate right to delete a stage.
    @PostMapping(value="/stagesManagement/delete/{id}")
    public ModelAndView deleteStage(HttpServletRequest request, @PathVariable Integer id) {
        try {
            // Session existence check.
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            // User right check.
            if (!user.getManagement()) {
                return new ModelAndView("redirect:/notFound");
            }
            // Stage existence check.
            Stage stage = stageService.findStageById(id);
            if (stage == null) {
                return new ModelAndView("redirect:/notFound");
            }
            // Delete execution.
            File file = new File(context.getRealPath(STATIC_FOLDER_PATH) + stage.getId());
            if (file.exists()) {
                FileUtils.forceDelete(file);
            }
            List<Reservation> activeReservations = reservationService.findStageActiveReservations(stage.getId());
            for (Reservation activeReservation : activeReservations) {
                mailService.sendEmail("Stage reservation cancelled!",
                        activeReservation.getCreatedBy().getEmail(),
                        "We are sorry to inform you that your reservation <b>" + activeReservation.getId()
                                + "</b> for event <b>" + activeReservation.getEvent()
                                + "</b> has been cancelled, as stage <b>" + activeReservation.getStage().getName() + "</b> is no longer available.");
            }
            stageService.delete(stage);
            return new ModelAndView("redirect:/stagesManagement");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

}
