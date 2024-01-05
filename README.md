# City Bike Tracker

## Table Of Contents

- [About the Project](#about-the-project)
- [Built With](#built-with)
- [Features](#features)
- [Usage](#usage)

## About The Project

The City Bike Tracker is a web/mobile application developed as a summer project for Oulu University of Applied Sciences during the summer of 2023. I got the project idea from the  [Solita Dev Academy pre-assignment of Spring 2023.](https://github.com/solita/dev-academy-2023-exercise) It provides a user-friendly interface to explore and analyze journey data from city bikes in the Helsinki Capital area. The application allows users to view lists of journeys and stations, and gather insights about bike usage in the region.

## Built With

- Frontend: Flutter
- Backend: Java Spring Boot
- Database: MySQL
- Maps Integration: Google Maps

## Features

### Data Import

- Import journey data from CSV files to the MySQL database.
- Validate data before importing.
- Exclude journeys that lasted less than ten seconds or covered distances shorter than 10 meters.

### Journey List View

- List journeys with departure and return stations, covered distance in kilometers, and duration in minutes.
- Pagination to handle large datasets.
- Searching and filtering of journeys.

### Station List

- List all bike stations.
- Search for a specific station.
- Selected station can be shown on map.

### Single Station View

- Display station information such as name, address etc.
- Show station location on the map.

### Google Maps Integration

- Full navigation with Google Maps.
- Utilize Google Maps for additional utilities.


## Usage

The City Bike Tracker application allows users to explore and analyze city bike journey data in the Helsinki Capital area. Users can import data, view lists of journeys and stations, and gather insights about bike usage. The user interface is intuitive, and additional details about usage can be found in the demo video [here](https://youtu.be/WRvs62JY7Cc).

