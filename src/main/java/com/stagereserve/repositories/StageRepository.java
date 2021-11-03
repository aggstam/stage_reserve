package com.stagereserve.repositories;

import com.stagereserve.models.Stage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StageRepository extends JpaRepository<Stage, Integer> {

    @Query("SELECT s FROM Stage s WHERE s.active = true")
    List<Stage> findActiveStages();

    @Query("SELECT s FROM Stage s WHERE s.id=:id")
    Stage findStageById(@Param("id") Integer id);

    @Query("SELECT s FROM Stage s WHERE s.id=:id AND s.active = true")
    Stage findActiveStageById(@Param("id") Integer id);

}
