package com.stagereserve.controllers;

import com.stagereserve.forms.LoginForm;
import com.stagereserve.forms.UserForm;
import com.stagereserve.models.User;
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
public class LoginController {

    private static final Logger logger = Logger.getLogger(LoginController.class.getName());
    private final String STATIC_FOLDER_PATH = "WEB-INF/resources/images/users/";
    private final String SYM_FOLDER_PATH = "/resources/images/users/";

    @Autowired
    private UserService userService;

    @Autowired
    private ServletContext context;

    // This method creates the login page view.
    @GetMapping(value="/")
    public ModelAndView getLogin() {
        try {
            return newLoginModelAndView(null);
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    // This method enables users to login to the site using their credentials.
    @PostMapping(value="/login")
    public ModelAndView postLogin(HttpServletRequest request, @Valid @ModelAttribute LoginForm loginForm) {
        try {
            // User login.
            User user = userService.findUserByEmailAndPassword(loginForm.getLoginEmail(), loginForm.getLoginPassword());
            if (user != null) {
                request.getSession().setAttribute("user", user);
                return new ModelAndView("redirect:/home");
            }
            return newLoginModelAndView("Username or password is incorrect. Please try again...");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    // This method enables users to create a site account.
    @PostMapping(value="/signup")
    public ModelAndView postSignup(HttpServletRequest request, @Valid @ModelAttribute UserForm userForm) {
        try {
            // User creation
            User user = new User();
            user.setEmail(userForm.getEmail());
            user.setPassword(userForm.getPassword());
            user.setName(userForm.getName());
            user.setSurname(userForm.getSurname());
            user.setPhone(userForm.getPhone());
            user.setManagement(false);
            user.setUsers(false);
            try {
                user = userService.save(user);
            } catch (Exception e) {
                return newLoginModelAndView("User already exists. Please choose another username...");
            }
            request.getSession().setAttribute("user", user);
            // User profile static image creation.
            user.setImage(SYM_FOLDER_PATH + user.getId() + File.separator + userForm.getFile().getOriginalFilename());
            String userFolderPath = context.getRealPath(STATIC_FOLDER_PATH) + user.getId();
            File userFolder = new File(userFolderPath);
            if (userFolder.exists()) {
                FileUtils.forceDelete(userFolder);
            }
            Files.createDirectories(Paths.get(userFolderPath));
            userFolderPath += File.separator;
            userForm.getFile().transferTo(new File(userFolderPath + userForm.getFile().getOriginalFilename()));
            userService.save(user);
            request.getSession().setAttribute("user", user);
            return new ModelAndView("redirect:/home");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    // This method creates the oath_callback page view, used for oauth authentication with Google account.
    @GetMapping(value="/oauth_callback")
    public ModelAndView getOauthCallback(HttpServletRequest request) {
        try {
            ModelAndView mav = new ModelAndView("oauth_callback");
            mav.addObject("userForm", new UserForm());
            return mav;
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    // This method enables users to login to the site using their Google account. If the user enters the site for the first time, a new site account is created.
    @PostMapping(value="/oauth_callback")
    public ModelAndView postOauthCallback(HttpServletRequest request, @Valid @ModelAttribute UserForm userForm) {
        try {
            // User login.
            User user = userService.findUserByEmail(userForm.getEmail());
            if (user == null) {
                // User creation
                user = new User();
                user.setEmail(userForm.getEmail());
                user.setName(userForm.getName());
                user.setSurname(userForm.getSurname());
                user.setPhone(userForm.getPhone());
                user.setImage(userForm.getImage());
                user.setManagement(false);
                user.setUsers(false);
                user = userService.save(user);
            }
            request.getSession().setAttribute("user", user);
            return new ModelAndView("redirect:/home");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    // This method creates a login page ModelAndView object.
    private ModelAndView newLoginModelAndView(String errorMessage) {
        ModelAndView mav = new ModelAndView("login");
        mav.addObject("loginForm", new LoginForm(errorMessage));
        mav.addObject("userForm", new UserForm());
        return mav;
    }

}
