package com.stagereserve.controllers;

import com.stagereserve.models.Reservation;
import com.stagereserve.models.User;
import com.stagereserve.services.MailService;
import com.stagereserve.services.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.DecimalFormat;
import java.util.*;
import java.util.logging.Logger;

@Controller
public class HistoryController {

    private static final Logger logger = Logger.getLogger(HistoryController.class.getName());

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private MailService mailService;

    // This method creates the history page view, accessible by users with the appropriate right.
    @GetMapping(value="/history")
    public ModelAndView getHistory(HttpServletRequest request) {
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
            List<Reservation> reservations = reservationService.findReservationsHistory();
            Map<Integer, String> capacityRateMap = new HashMap<>();
            DecimalFormat formatter = new DecimalFormat("#0.00");
            reservations.forEach(r -> {
                capacityRateMap.put(r.getId(), formatter.format((((double) r.getAttendees().size() / r.getStage().getCapacity()) * 100)));
            });
            ModelAndView mav = new ModelAndView("history");
            mav.addObject("user", user);
            mav.addObject("reservations", reservations);
            mav.addObject("capacityRateMap", capacityRateMap);
            return mav;
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    // This method enables users with appropriate right to delete a reservation.
    @PostMapping(value="/history/delete/{id}")
    public ModelAndView deleteReservation(HttpServletRequest request, @PathVariable Integer id) {
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
            // Reservation existence check.
            Reservation reservation = reservationService.findReservationById(id);
            if (reservation == null) {
                return new ModelAndView("redirect:/notFound");
            }
            // Delete execution.
            Date now = new Date();
            if (now.before(reservation.getReserveTo())) {
                mailService.sendEmail("Stage reservation cancelled!",
                        reservation.getCreatedBy().getEmail(),
                        "<p>We are sorry to inform you that your reservation <b>" + reservation.getId()
                                + "</b> for event <b>" + reservation.getEvent()
                                + "</b> has been cancelled by our administrators.</p><p>Feel free to contract us if more information is required!</p>");
            }
            reservationService.delete(reservation);
            return new ModelAndView("redirect:/history");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

}
