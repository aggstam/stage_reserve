package com.stagereserve.repositories;

import com.stagereserve.models.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Integer> {

    @Query("SELECT r FROM Reservation r WHERE r.id = :id")
    Reservation findReservationById(@Param("id") Integer id);

    @Query("SELECT r FROM Reservation r WHERE r.createdBy.id = :userId AND r.stage.active = true AND r.reserveTo > :date ORDER BY r.reserveFrom ASC")
    List<Reservation> findUserActiveReservations(@Param("userId")Integer userId, @Param("date") Date date);

    @Query("SELECT r FROM Reservation r WHERE r.createdBy.id = :userId AND r.stage.active = true AND r.reserveTo < :date ORDER BY r.reserveTo DESC")
    List<Reservation> findUserPastReservations(@Param("userId")Integer userId, @Param("date") Date date);

    @Query("SELECT r FROM Reservation r WHERE r.stage.id = :stageId AND r.reserveTo > :date ORDER BY r.reserveFrom ASC")
    List<Reservation> findStageActiveReservations(@Param("stageId")Integer stageId, @Param("date") Date date);

}
