package com.citybike.server.repository;

import com.citybike.server.data.TravelData;

import java.time.LocalDateTime;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface TravelDataRepo extends JpaRepository<TravelData, Long> {

        @Query("SELECT t FROM TravelData t WHERE " +
                        "(:minDeparture IS NULL OR t.departure >= :minDeparture) AND " +
                        "(:maxDeparture IS NULL OR t.departure <= :maxDeparture) AND " +
                        "(:minArrival IS NULL OR t.arrival >= :minArrival) AND " +
                        "(:maxArrival IS NULL OR t.arrival <= :maxArrival) AND " +
                        "(:departureStationId IS NULL OR t.departureStationId = :departureStationId) AND " +
                        "(:arrivalStationId IS NULL OR t.arrivalStationId = :arrivalStationId) AND " +
                        "(:minDistance IS NULL OR t.distanceCoveredinMeters >= :minDistance) AND " +
                        "(:minDuration IS NULL OR t.durationInSeconds >= :minDuration)")
        Page<TravelData> searchTrips(
                        @Param("minDeparture") LocalDateTime minDeparture,
                        @Param("maxDeparture") LocalDateTime maxDeparture,
                        @Param("minArrival") LocalDateTime minArrival,
                        @Param("maxArrival") LocalDateTime maxArrival,
                        @Param("departureStationId") Integer departureStationId,
                        @Param("arrivalStationId") Integer arrivalStationId,
                        @Param("minDistance") Integer minDistance,
                        @Param("minDuration") Integer minDuration,
                        PageRequest pageRequest);

}
