package com.stagereserve.controllers;

import com.stagereserve.models.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.logging.Logger;

@Controller
public class ErrorController {

    private static final Logger logger = Logger.getLogger(ErrorController.class.getName());

    // This method creates the error page view.
    @GetMapping(value="/error")
    public ModelAndView getError(HttpServletRequest request) {
        try {
            // Session existence check.
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            // View creation.
            ModelAndView mav = (request.getAttribute("javax.servlet.error.status_code").equals(404)) ? new ModelAndView("notFound") : new ModelAndView("error");
            mav.addObject("user", user);
            return mav;
        } catch (Exception e) {
            return new ModelAndView("/error");
        }
    }

    // This method creates the notFound page view.
    @GetMapping(value="/notFound")
    public ModelAndView getNotFound(HttpServletRequest request) {
        try {
            // Session existence check.
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            // View creation.
            ModelAndView mav = new ModelAndView("notFound");
            mav.addObject("user", user);
            return mav;
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

}
