package com.citybike.server.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.citybike.server.data.TravelData;
import com.citybike.server.service.TravelDataService;

@CrossOrigin
@RestController
public class DataController {

    @Autowired
    private TravelDataService travelData;

    @GetMapping("/allTravelData")
    public List<TravelData> getAllTravelData() {
        return travelData.getAllTravelData();
    }

}
