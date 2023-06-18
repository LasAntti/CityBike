package com.citybike.server.service;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class databaseServiceStations {
    public static void main(String[] args) {

        String jdbcurl = "jdbc:mysql://localhost:3306/city_bike";
        String username = "root";
        String password = "";
        String filepath = "server\\src\\main\\resources\\datasets\\Helsingin_ja_Espoon_kaupunkipyöräasemat_avoin.csv";

        int batchSize = 20;

        Connection connection = null;

        try {
            connection = DriverManager.getConnection(jdbcurl, username, password);
            connection.setAutoCommit(false);

            String sql = "insert into station_data (fid, id, nimi, namn, name, osoite, adress, kaupunki, stad, operator, capacity, lon, lat ) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";

            PreparedStatement statement = connection.prepareStatement(sql);

            BufferedReader linReader = new BufferedReader(
                    new InputStreamReader(new FileInputStream(filepath), StandardCharsets.UTF_8));

            String lineText = null;
            int count = 0;

            linReader.readLine();
            while ((lineText = linReader.readLine()) != null) {
                String[] data = lineText.split(",");
                String fid = data[0];
                String id = data[1];
                String nimi = data[2];
                String namn = data[3];
                String name = data[4];
                String osoite = data[5];
                String adress = data[6];
                String kaupunki = data[7];
                String stad = data[8];
                String operator = data[9];
                String capacity = data[10];
                String lon = data[11];
                String lat = data[12];

                statement.setObject(1, parseIntegerOrNull(fid));
                statement.setObject(2, parseIntegerOrNull(id));
                statement.setString(3, nimi);
                statement.setString(4, namn);
                statement.setString(5, name);
                statement.setString(6, osoite);
                statement.setString(7, adress);
                statement.setString(8, kaupunki);
                statement.setString(9, stad);
                statement.setString(10, operator);
                statement.setObject(11, parseIntegerOrNull(capacity));
                statement.setObject(12, parseDoubleOrNull(lon));
                statement.setObject(13, parseDoubleOrNull(lat));
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

    private static Double parseDoubleOrNull(String value) {
        try {
            return Double.parseDouble(value);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
