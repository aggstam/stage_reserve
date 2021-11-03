package com.stagereserve.controllers;

import com.stagereserve.models.Attendee;
import com.stagereserve.models.Reservation;
import com.stagereserve.models.User;
import com.stagereserve.services.AttendeeService;
import com.stagereserve.services.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.Optional;
import java.util.logging.Logger;

@Controller
public class CheckinController {

    private static final Logger logger = Logger.getLogger(CheckinController.class.getName());

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private AttendeeService attendeeService;

    // This method creates the checkin page view.
    @GetMapping(value="/checkin")
    public ModelAndView getCheckin(HttpServletRequest request, @RequestParam(required = false) Integer code) {
        try {
            // Session existence check.
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            // View creation.
            ModelAndView mav = new ModelAndView("checkin");
            mav.addObject("user", user);
            if (code != null) {
                Reservation reservation = reservationService.findReservationById(code);
                if (reservation != null) {
                    mav.addObject("reservation", reservation);
                    Date now = new Date();
                    if (now.after(reservation.getReserveFrom()) && now.before(reservation.getReserveTo())) {
                        Optional<Attendee> attended = reservation.getAttendees().stream().parallel().filter(a -> a.getUser().getId().equals(user.getId())).findAny();
                        if (!attended.isPresent()) {
                            if (reservation.getAttendees().size() < reservation.getStage().getCapacity()) {
                                mav.addObject("canCheckin", true);
                            } else {
                                mav.addObject("checkinMessage", "Event have reached max capacity!");
                            }
                        } else {
                            mav.addObject("checkinMessage", "You have already checked in!");
                        }
                    } else if (now.after(reservation.getReserveTo())) {
                        mav.addObject("checkinMessage", "Event was concluded.");
                    } else {
                        mav.addObject("showCountdown", true);
                        mav.addObject("checkinMessage", "Checkin opens after event has started.");
                    }
                } else {
                    mav.addObject("controllerMessage", "Event was not found! Please search another code...");
                }
            }
            return mav;
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    // This method enables users to checkin to a reservation.
    @PostMapping(value="/checkin/{id}")
    public ModelAndView postCheckin(HttpServletRequest request, @PathVariable Integer id) {
        try {
            // Session existence check.
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            // Reservation existence check.
            Reservation reservation = reservationService.findReservationById(id);
            if (reservation == null) {
                return new ModelAndView("redirect:/notFound");
            }
            // Checkin execution.
            Date now = new Date();
            if (now.after(reservation.getReserveFrom()) && now.before(reservation.getReserveTo())) {
                Optional<Attendee> attended = reservation.getAttendees().stream().parallel().filter(a -> a.getUser().getId().equals(user.getId())).findAny();
                if (!attended.isPresent() && reservation.getAttendees().size() < reservation.getStage().getCapacity()) {
                    Attendee attendee = new Attendee();
                    attendee.setReservation(reservation);
                    attendee.setUser(user);
                    attendee.setTimestamp(now);
                    attendeeService.save(attendee);
                }
            }
            return new ModelAndView("redirect:/checkin?code=" + id);
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

}
