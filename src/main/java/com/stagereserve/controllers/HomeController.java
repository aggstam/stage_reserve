package com.stagereserve.controllers;

import com.stagereserve.models.Stage;
import com.stagereserve.models.User;
import com.stagereserve.services.StageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.logging.Logger;

@Controller
public class HomeController {

    private static final Logger logger = Logger.getLogger(HomeController.class.getName());

    @Autowired
    private StageService stageService;

    // This method creates the home page view.
    @GetMapping(value="/home")
    public ModelAndView getHome(HttpServletRequest request) {
        try {
            // Session existence check.
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            // View creation.
            List<Stage> stages = stageService.findActiveStages();
            ModelAndView mav = new ModelAndView("home");
            mav.addObject("user", user);
            mav.addObject("stages", stages);
            return mav;
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

}
