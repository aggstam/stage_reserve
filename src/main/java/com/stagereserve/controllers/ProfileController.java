package com.stagereserve.controllers;

import com.stagereserve.models.User;
import com.stagereserve.forms.UserForm;
import com.stagereserve.services.UserService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.logging.Logger;

@Controller
public class ProfileController {

    private static final Logger logger = Logger.getLogger(ProfileController.class.getName());
    private final String STATIC_FOLDER_PATH = "WEB-INF/resources/images/users/";
    private final String SYM_FOLDER_PATH = "/resources/images/users/";

    @Autowired
    private UserService userService;

    @Autowired
    private ServletContext context;

    // This method creates the profile page view.
    @GetMapping(value="/profile")
    public ModelAndView getProfile(HttpServletRequest request) {
        try {
            // Session existence check.
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            // View creation.
            ModelAndView mav = new ModelAndView("profile");
            mav.addObject("user", user);
            mav.addObject("userForm", new UserForm(user));
            return mav;
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    // This method enables users to edit their profile information.
    @PostMapping(value="/profile")
    public ModelAndView postProfile(HttpServletRequest request, @Valid @ModelAttribute UserForm userForm) {
        try {
            // Session existence check.
            User sessionUser = (User) request.getSession().getAttribute("user");
            if (sessionUser == null) {
                return new ModelAndView("redirect:/");
            }
            // Edit execution.
            sessionUser.setPassword(userForm.getPassword());
            sessionUser.setName(userForm.getName());
            sessionUser.setSurname(userForm.getSurname());
            sessionUser.setPhone(userForm.getPhone());
            if (userForm.getFile() != null && !userForm.getFile().isEmpty()) {
                // User profile static image update.
                sessionUser.setImage(SYM_FOLDER_PATH + sessionUser.getId() + File.separator + userForm.getFile().getOriginalFilename());
                String userFolderPath = context.getRealPath(STATIC_FOLDER_PATH) + sessionUser.getId();
                File userFolder = new File(userFolderPath);
                if (userFolder.exists()) {
                    FileUtils.forceDelete(userFolder);
                }
                Files.createDirectories(Paths.get(userFolderPath));
                userFolderPath += File.separator;
                userForm.getFile().transferTo(new File(userFolderPath + userForm.getFile().getOriginalFilename()));
            }
            sessionUser = userService.save(sessionUser);
            request.getSession().setAttribute("user", sessionUser);
            return new ModelAndView("redirect:/profile");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

}
