package com.citybike.server.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.citybike.server.repository.TravelDataRepo;
import com.citybike.server.data.TravelData;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;

@Service
public class TravelDataService {

    @Autowired
    private TravelDataRepo travelRepo;

    public List<TravelData> getAllTravelData(int page) {
        PageRequest pageRequest = PageRequest.of(page, 100, Sort.by(Sort.Direction.ASC, "id"));
        return travelRepo.findAll(pageRequest).getContent();
    }

    public Page<TravelData> searchTrips(
            LocalDateTime minDeparture,
            LocalDateTime maxDeparture,
            LocalDateTime minArrival,
            LocalDateTime maxArrival,
            Integer departureStationId,
            Integer arrivalStationId,
            Integer minDistance,
            Integer minDuration,
            int page,
            int size) {
        PageRequest pageRequest = PageRequest.of(page, size);
        return travelRepo.searchTrips(
                minDeparture,
                maxDeparture,
                minArrival,
                maxArrival,
                departureStationId,
                arrivalStationId,
                minDistance,
                minDuration,
                pageRequest);
    }

}
