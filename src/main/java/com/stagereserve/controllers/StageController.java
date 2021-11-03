package com.stagereserve.controllers;

import com.stagereserve.forms.ReservationForm;
import com.stagereserve.models.Reservation;
import com.stagereserve.models.Stage;
import com.stagereserve.models.User;
import com.stagereserve.services.MailService;
import com.stagereserve.services.ReservationService;
import com.stagereserve.services.StageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.logging.Logger;

@Controller
public class StageController {

    private static final Logger logger = Logger.getLogger(HomeController.class.getName());

    @Autowired
    private StageService stageService;

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private MailService mailService;

    // This method creates the reservations page view.
    @GetMapping(value="/stage/{id}")
    public ModelAndView getStage(HttpServletRequest request, @PathVariable Integer id) {
        try {
            // Session existence check.
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            // Stage existence check.
            Stage stage = stageService.findActiveStageById(id);
            if (stage == null) {
                return new ModelAndView("redirect:/notFound");
            }
            // View creation.
            List<Reservation> reservations = reservationService.findStageActiveReservations(stage.getId());
            ModelAndView mav = new ModelAndView("stage");
            mav.addObject("user", user);
            mav.addObject("stage", stage);
            mav.addObject("reservations", reservations);
            mav.addObject("reservationForm", new ReservationForm());
            return mav;
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    // This method enables users to make a reservation to a stage.
    @PostMapping(value="/stage/makeReservation/{id}")
    public ModelAndView makeReservation(HttpServletRequest request, @PathVariable Integer id, @Valid @ModelAttribute ReservationForm reservationForm) {
        try {
            // Session existence check.
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            // Stage existence check.
            Stage stage = stageService.findActiveStageById(id);
            if (stage == null) {
                return new ModelAndView("redirect:/notFound");
            }
            // Reservation execution.
            Reservation reservation = new Reservation();
            reservation.setStage(stage);
            reservation.setCreatedBy(user);
            reservation.setEvent(reservationForm.getEvent());
            String[] dateRange = reservationForm.getDatesTimeString().split(" - ");
            SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy HH:mm");
            reservation.setReserveFrom(formatter.parse(dateRange[0]));
            reservation.setReserveTo(formatter.parse(dateRange[1]));
            reservationService.save(reservation);
            mailService.sendEmail("Stage reservation made!",
                    reservation.getCreatedBy().getEmail(),
                    "<p>We are happy to inform you that your reservation of stage <b>" + reservation.getStage().getName()
                            + "</b> for event <b>" + reservation.getEvent()
                            + "</b> has been created!</p><p>Use Event code <b>" + reservation.getId()
                            + "</b> for checkin!</p><p>Feel free to contract us if more information is required!</p>");
            if (reservationForm.getInvites() != null) {
                mailService.sendEmail("Event invite!",
                        reservationForm.getInvites().replaceAll("\\s+","").split(","),
                        "<p>You have been invited to event <b>" + reservation.getEvent()
                                + "</b> by " + reservation.getCreatedBy().getEmail()
                                + "!</p><p>Use Event code <b>" + reservation.getId()
                                + "</b> for checkin!</p><p>Feel free to contract us if more information is required!</p>");
            }
            return new ModelAndView("redirect:/stage/" + id);
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

}
