package com.citybike.server.repository;

import com.citybike.server.data.TravelData;

import org.springframework.data.jpa.repository.JpaRepository;

public interface TravelDataRepo extends JpaRepository<TravelData, Long> {

}
