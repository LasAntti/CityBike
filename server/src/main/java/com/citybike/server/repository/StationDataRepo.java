package com.citybike.server.repository;

import com.citybike.server.data.StationData;

import org.springframework.data.jpa.repository.JpaRepository;

public interface StationDataRepo extends JpaRepository<StationData, Long> {
    
}
