package com.citybike.server.service;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class databaseServiceTrips {
    public static void main(String[] args) {

        String jdbcurl = "jdbc:mysql://localhost:3306/city_bike";
        String username = "root";
        String password = "";
        String filepath = "server\\src\\main\\resources\\datasets\\2021-07.csv";

        int batchSize = 20;

        Connection connection = null;

        try {
            connection = DriverManager.getConnection(jdbcurl, username, password);
            connection.setAutoCommit(false);

            String sql = "insert into travel_data (departure, arrival, departure_station_id, departure_station_name, arrival_station_id, arrival_station_name, distance_coveredin_meters, duration_in_seconds ) values(?,?,?,?,?,?,?,?)";

            PreparedStatement statement = connection.prepareStatement(sql);

            BufferedReader linReader = new BufferedReader(
                    new InputStreamReader(new FileInputStream(filepath), StandardCharsets.UTF_8));

            String lineText = null;
            int count = 0;

            linReader.readLine();
            while ((lineText = linReader.readLine()) != null) {
                String[] data = lineText.split(",");
                String departure = data[0];
                String arrival = data[1];
                String departure_station_id = data[2];
                String departure_station_name = data[3];
                String arrival_station_id = data[4];
                String arrival_station_name = data[5];
                String distance_coveredin_meters = data[6];
                String duration_in_seconds = data[7];

                if (parseLongOrNull(distance_coveredin_meters) == null || parseLongOrNull(duration_in_seconds) == null
                        || parseLongOrNull(distance_coveredin_meters) < 10 || parseLongOrNull(duration_in_seconds) < 10
                        || duration_in_seconds == null || arrival_station_id == null) {
                    continue; // Skip this entry
                }

                statement.setString(1, departure);
                statement.setString(2, arrival);
                statement.setObject(3, parseIntegerOrNull(departure_station_id));
                statement.setString(4, departure_station_name);
                statement.setObject(5, parseIntegerOrNull(arrival_station_id));
                statement.setString(6, arrival_station_name);
                statement.setObject(7, parseLongOrNull(distance_coveredin_meters));
                statement.setObject(8, parseLongOrNull(duration_in_seconds));
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