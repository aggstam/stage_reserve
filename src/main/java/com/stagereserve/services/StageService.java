package com.stagereserve.services;

import com.stagereserve.models.Stage;
import com.stagereserve.repositories.StageRepository;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class StageService {

    @Resource
    private StageRepository stageRepository;

    public Stage save(Stage stage) {
        return stageRepository.save(stage);
    }

    public void delete(Stage stage) {
        stageRepository.delete(stage);
    }

    public List<Stage> findAll() {
        return stageRepository.findAll();
    }

    public List<Stage> findActiveStages() {
        return stageRepository.findActiveStages();
    }

    public Stage findStageById(Integer id) {
        return stageRepository.findStageById(id);
    }

    public Stage findActiveStageById(Integer id) {
        return stageRepository.findActiveStageById(id);
    }

}
