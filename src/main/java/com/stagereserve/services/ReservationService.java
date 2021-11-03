package com.stagereserve.services;

import com.stagereserve.models.Reservation;
import com.stagereserve.repositories.ReservationRepository;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class ReservationService {

    @Resource
    private ReservationRepository reservationRepository;

    public Reservation findReservationById(Integer id) {
        return reservationRepository.findReservationById(id);
    }

    public List<Reservation> findUserActiveReservations(Integer userId) {
        return reservationRepository.findUserActiveReservations(userId, new Date());
    }

    public List<Reservation> findUserPastReservations(Integer userId) {
        return reservationRepository.findUserPastReservations(userId, new Date());
    }

    public List<Reservation> findStageActiveReservations(Integer stageId) {
        return reservationRepository.findStageActiveReservations(stageId, new Date());
    }

    public void delete(Reservation reservation) {
        reservationRepository.delete(reservation);
    }

    public Reservation save(Reservation reservation) {
        return reservationRepository.save(reservation);
    }

    public List<Reservation> findReservationsHistory() {
        return reservationRepository.findAll();
    }

}
