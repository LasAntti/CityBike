package com.citybike.server.data;


import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class TravelData {
    

    @Id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private long id;

    private String departure;
    private String arrival;
    private int departureStationId;
    private String departureStationName;
    private Integer arrivalStationId;
    private String arrivalStationName;
    private Long distanceCoveredinMeters;
    private Long durationInSeconds;

    public TravelData() {
    }

    public TravelData(String departure, String arrival, int departureStationId, String departureStationName,
            Integer arrivalStationId, String arrivalStationName, Long distanceCoveredinMeters, Long durationInSeconds) {
        this.departure = departure;
        this.arrival = arrival;
        this.departureStationId = departureStationId;
        this.departureStationName = departureStationName;
        this.arrivalStationId = arrivalStationId;
        this.arrivalStationName = arrivalStationName;
        this.distanceCoveredinMeters = distanceCoveredinMeters;
        this.durationInSeconds = durationInSeconds;
    }


    public long getId() {
        return this.id;
    }

    public String getDeparture() {
        return this.departure;
    }

    public void setDeparture(String departure) {
        this.departure = departure;
    }

    public String getArrival() {
        return this.arrival;
    }

    public void setArrival(String arrival) {
        this.arrival = arrival;
    }

    public int getDepartureStationId() {
        return this.departureStationId;
    }

    public void setDepartureStationId(int departureStationId) {
        this.departureStationId = departureStationId;
    }

    public String getDepartureStationName() {
        return this.departureStationName;
    }

    public void setDepartureStationName(String departureStationName) {
        this.departureStationName = departureStationName;
    }

    public Integer getArrivalStationId() {
        return this.arrivalStationId;
    }

    public void setArrivalStationId(Integer arrivalStationId) {
        this.arrivalStationId = arrivalStationId;
    }

    public String getArrivalStationName() {
        return this.arrivalStationName;
    }

    public void setArrivalStationName(String arrivalStationName) {
        this.arrivalStationName = arrivalStationName;
    }

    public Long getDistanceCoveredinMeters() {
        return this.distanceCoveredinMeters;
    }

    public void setDistanceCoveredinMeters(Long distanceCoveredinMeters) {
        this.distanceCoveredinMeters = distanceCoveredinMeters;
    }

    public Long getDurationInSeconds() {
        return this.durationInSeconds;
    }

    public void setDurationInSeconds(Long durationInSeconds) {
        this.durationInSeconds = durationInSeconds;
    }
    

}
