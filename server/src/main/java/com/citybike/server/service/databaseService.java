package com.citybike.server.service;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class databaseService {
    public static void main(String[] args) {

        String jdbcurl = "jdbc:mysql://localhost:3306/citybike";
        String username = "root";
        String password = "";
        String filepath = "src\\main\\resources\\datasets\\2021-05.csv";

        int batchSize = 20;

        Connection connection = null;

        try {
            connection = DriverManager.getConnection(jdbcurl, username, password);
            connection.setAutoCommit(false);

            String sql = "insert into travel_data (departure, arrival, departure_station_id, departure_station_name,arrival_station_id, arrival_station_name, distance_coveredin_meters,duration_in_seconds ) values(?,?,?,?,?,?,?,?)";

            PreparedStatement statement = connection.prepareStatement(sql);

            BufferedReader linReader = new BufferedReader(new FileReader(filepath));

            String lineText = null;
            int count = 0;

            linReader.readLine();
            while ((lineText = linReader.readLine()) != null) {
                String[] data = lineText.split(",");
                String departure = data[0];
                String arrival = data[1];
                String departureStationID = data[2];
                String departureStationName = data[3];
                String arrivalStationID = data[4];
                String arrivalStationName = data[5];
                String distanceCoveredinMeters = data[6];
                String durationInSeconds = data[7];

                statement.setString(1, departure);
                statement.setString(2, arrival);
                statement.setObject(3, parseIntegerOrNull(departureStationID));
                statement.setString(4, departureStationName);
                statement.setObject(5, parseIntegerOrNull(arrivalStationID));
                statement.setString(6, arrivalStationName);
                statement.setObject(7, parseLongOrNull(distanceCoveredinMeters));
                statement.setObject(8, parseLongOrNull(durationInSeconds));

                statement.addBatch();
                if (count % batchSize == 0) {
                    statement.executeBatch();
                }
            }
            linReader.close();
            statement.executeBatch();
            connection.commit();
            connection.close();
            System.out.println("data has been inserted");

        } catch (Exception e) {
            e.printStackTrace();
        } 
        
    }

    private static Integer parseIntegerOrNull(String value) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return null;
        }
    }
    
    private static Long parseLongOrNull(String value) {
        try {
            return Long.parseLong(value);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}