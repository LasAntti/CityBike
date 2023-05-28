package com.citybike.server.data;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class StationData {
    
@Id
private int FID;

private int id;
private String nimi;
private String namn;
private String name;
private String osoite;
private String adress;
private String kaupunki;
private String stad;
private String operator;
private Integer capacity;
private Double lat;
private Double lon;

public StationData() {

}

public StationData(int FID, int id, String nimi, String namn, String name, String osoite, String adress,
        String kaupunki, String stad, String operator, Integer capacity, Double lat, Double lon) {
    this.FID = FID;
    this.id = id;
    this.nimi = nimi;
    this.namn = namn;
    this.name = name;
    this.osoite = osoite;
    this.adress = adress;
    this.kaupunki = kaupunki;
    this.stad = stad;
    this.operator = operator;
    this.capacity = capacity;
    this.lat = lat;
    this.lon = lon;
}




    public int getFID() {
        return this.FID;
    }

    public void setFID(int FID) {
        this.FID = FID;
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNimi() {
        return this.nimi;
    }

    public void setNimi(String nimi) {
        this.nimi = nimi;
    }

    public String getNamn() {
        return this.namn;
    }

    public void setNamn(String namn) {
        this.namn = namn;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOsoite() {
        return this.osoite;
    }

    public void setOsoite(String osoite) {
        this.osoite = osoite;
    }

    public String getAdress() {
        return this.adress;
    }

    public void setAdress(String adress) {
        this.adress = adress;
    }

    public String getKaupunki() {
        return this.kaupunki;
    }

    public void setKaupunki(String kaupunki) {
        this.kaupunki = kaupunki;
    }

    public String getStad() {
        return this.stad;
    }

    public void setStad(String stad) {
        this.stad = stad;
    }

    public String getOperator() {
        return this.operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public Integer getCapacity() {
        return this.capacity;
    }

    public void setCapacity(Integer capacity) {
        this.capacity = capacity;
    }

    public Double getLat() {
        return this.lat;
    }

    public void setLat(Double lat) {
        this.lat = lat;
    }

    public Double getLon() {
        return this.lon;
    }

    public void setLon(Double lon) {
        this.lon = lon;
    }



}
