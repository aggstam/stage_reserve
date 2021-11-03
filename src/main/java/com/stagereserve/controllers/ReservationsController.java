package com.stagereserve.controllers;

import com.stagereserve.models.Reservation;
import com.stagereserve.models.User;
import com.stagereserve.services.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.logging.Logger;

@Controller
public class ReservationsController {

    private static final Logger logger = Logger.getLogger(ReservationsController.class.getName());

    @Autowired
    private ReservationService reservationService;

    // This method creates the reservations page view.
    @GetMapping(value="/reservations")
    public ModelAndView getReservations(HttpServletRequest request) {
        try {
            // Session existence check.
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            // View creation.
            List<Reservation> reservations = reservationService.findUserActiveReservations(user.getId());
            List<Reservation> pastReservations = reservationService.findUserPastReservations(user.getId());
            ModelAndView mav = new ModelAndView("reservations");
            mav.addObject("user", user);
            mav.addObject("reservations", reservations);
            mav.addObject("pastReservations", pastReservations);
            return mav;
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

}
