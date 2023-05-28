package com.citybike.server.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.citybike.server.data.TravelData;
import com.citybike.server.service.StationDataService;
import com.citybike.server.service.TravelDataService;

@CrossOrigin
@RestController
public class DataController {

    @Autowired
    private TravelDataService travelData;

    @Autowired
    private StationDataService stationData;

    @GetMapping("/allTravelData")
    public List<TravelData> getAllTravelData() {
        return travelData.getAllTravelData();
    }

    @GetMapping("/allStationData")
    public List<com.citybike.server.data.StationData> getAllStationData() {
        return stationData.getAllStationData();
    }

}
