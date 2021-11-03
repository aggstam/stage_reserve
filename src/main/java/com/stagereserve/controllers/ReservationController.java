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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.logging.Logger;

@Controller
public class ReservationController {

    private static final Logger logger = Logger.getLogger(ReservationController.class.getName());

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private MailService mailService;

    // This method creates the reservation page view.
    @GetMapping(value="/reservation/{id}")
    public ModelAndView getReservation(HttpServletRequest request, @PathVariable Integer id) {
        try {
            // Session existence check.
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            // Reservation existence check.
            Reservation reservation = reservationService.findReservationById(id);
            if (reservation == null || !reservation.getCreatedBy().getId().equals(user.getId())) {
                return new ModelAndView("redirect:/notFound");
            }
            // View creation.
            ModelAndView mav = new ModelAndView("reservation");
            mav.addObject("user", user);
            mav.addObject("reservation", reservation);
            DecimalFormat formatter = new DecimalFormat("#0.00");
            mav.addObject("capacityRate", formatter.format((((double) reservation.getAttendees().size() / reservation.getStage().getCapacity()) * 100)));
            mav.addObject("isActive", reservation.getReserveFrom().after(new Date()) && reservation.getReserveTo().after(new Date()));
            return mav;
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    // This method enables users to cancel a reservation.
    @PostMapping(value="/reservation/delete/{id}")
    public ModelAndView deleteReservation(HttpServletRequest request, @PathVariable Integer id) {
        try {
            // Session existence check.
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            // Reservation existence check.
            Reservation reservation = reservationService.findReservationById(id);
            if (reservation == null || !reservation.getCreatedBy().getId().equals(user.getId()) || !(reservation.getReserveFrom().after(new Date()) && reservation.getReserveTo().after(new Date()))) {
                return new ModelAndView("redirect:/notFound");
            }
            // Delete execution.
            reservationService.delete(reservation);
            return new ModelAndView("redirect:/reservations");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    // This method enables users to invite people to a reservation.
    @PostMapping(value="/reservation/invite/{id}")
    public ModelAndView inviteAttendees(HttpServletRequest request, @PathVariable Integer id, @RequestParam(required = false) String invites) {
        try {
            // Session existence check.
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            // Reservation existence check.
            Reservation reservation = reservationService.findReservationById(id);
            if (reservation == null || !reservation.getCreatedBy().getId().equals(user.getId()) || !(reservation.getReserveFrom().after(new Date()) && reservation.getReserveTo().after(new Date()))) {
                return new ModelAndView("redirect:/notFound");
            }
            // Invite execution.
            if (invites != null) {
                mailService.sendEmail("Event invite!",
                        invites.replaceAll("\\s+","").split(","),
                        "<p>You have been invited to event <b>" + reservation.getEvent()
                                + "</b> by " + reservation.getCreatedBy().getEmail()
                                + "!</p><p>Use Event code <b>" + reservation.getId()
                                + "</b> for checkin!</p><p>Feel free to contract us if more information is required!</p>");
            }
            return new ModelAndView("redirect:/reservation/" + id);
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

}
