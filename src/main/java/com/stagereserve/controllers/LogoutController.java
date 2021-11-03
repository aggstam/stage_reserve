package com.stagereserve.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.logging.Logger;

@Controller
public class LogoutController {

    private static final Logger logger = Logger.getLogger(LogoutController.class.getName());

    // This method removes the user object from the session(invalidates it) and redirects the user to login page.
    @GetMapping(value="/logout")
    public ModelAndView getLogout(HttpServletRequest request) {
        try {
            request.getSession().removeAttribute("user");
            return new ModelAndView("redirect:/");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    // This method removes the user object from the session(invalidates it) and redirects the user to login page.
    @PostMapping(value="/logout")
    public ModelAndView postLogout(HttpServletRequest request) {
        try {
            request.getSession().removeAttribute("user");
            return new ModelAndView("redirect:/");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

}
