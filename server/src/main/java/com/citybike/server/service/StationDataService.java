package com.citybike.server.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import com.citybike.server.data.StationData;
import com.citybike.server.repository.StationDataRepo;

@Service
public class StationDataService {

    @Autowired
    private StationDataRepo stationRepo;

    public List<StationData> getAllStationData() {
        return stationRepo.findAll();
    }

}
