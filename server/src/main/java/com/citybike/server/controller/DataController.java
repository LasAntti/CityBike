package com.citybike.server.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

    
    // Returns all trips in pages of 100, if page is not specified, returns first page
    @GetMapping("/allTravelData")
    public List<TravelData> getAllTravelData(@RequestParam(defaultValue = "0") int page) {
        return travelData.getAllTravelData(page);
    }

    @GetMapping("/allStationData")
    public List<com.citybike.server.data.StationData> getAllStationData() {
        return stationData.getAllStationData();
    }

}
