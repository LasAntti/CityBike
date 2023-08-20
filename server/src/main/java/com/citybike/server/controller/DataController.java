package com.citybike.server.controller;

import java.time.LocalDateTime;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.format.annotation.DateTimeFormat;
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

    // Returns all trips in pages of 100, if page is not specified, returns first
    // page
    @GetMapping("/allTravelData")
    public List<TravelData> getAllTravelData(@RequestParam(defaultValue = "0") int page) {
        return travelData.getAllTravelData(page);
    }

    @GetMapping("/allStationData")
    public List<com.citybike.server.data.StationData> getAllStationData() {
        return stationData.getAllStationData();
    }

    @GetMapping("/searchTrips")
    public Page<TravelData> searchTrips(
    @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime minDeparture,
    @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime maxDeparture,
    @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime minArrival,
    @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime maxArrival,
    @RequestParam(required = false) Integer departureStationId,
    @RequestParam(required = false) Integer arrivalStationId,
    @RequestParam(required = false) Long minDistance,
    @RequestParam(required = false) Long minDuration,
    @RequestParam(defaultValue = "0") Integer page,
    @RequestParam(defaultValue = "100") Integer size) {

    // Convert LocalDateTime objects to ISO date-time strings
    String minDepartureStr = (minDeparture != null) ? minDeparture.toString() : null;
    String maxDepartureStr = (maxDeparture != null) ? maxDeparture.toString() : null;
    String minArrivalStr = (minArrival != null) ? minArrival.toString() : null;
    String maxArrivalStr = (maxArrival != null) ? maxArrival.toString() : null;

    return travelData.searchTrips(
        minDepartureStr,
        maxDepartureStr,
        minArrivalStr,
        maxArrivalStr,
        departureStationId,
        arrivalStationId,
        minDistance,
        minDuration,
        page,
        size);
}


}
