import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Station {
  int id;
  String name;
  String address;
  double latitude;
  double longitude;

  Station({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

Future<List<Station>> getAllBikeStations() async {
  try {
    final url = Uri.parse('http://192.168.1.188:8080/allStationData');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = response.body;
      final dynamicData = jsonDecode(jsonData) as List<dynamic>;
      List<Station> stations = [];

      for (var data in dynamicData) {
        if (data['lat'] != null && data['lon'] != null) {
          Station station = Station(
            id: data['id'] as int,
            name: data['nimi'] as String,
            address: data['osoite'] as String,
            latitude: data['lat'] as double,
            longitude: data['lon'] as double,
          );
          stations.add(station);
          print('Station: ${station.name} added to list');
          print('id: ${station.id}');
          print('Address: ${station.address}');
          print('Latitude: ${station.latitude}');
          print('Longitude: ${station.longitude}');
        }
      }
      return stations;
    } else {
      throw Exception('Failed to fetch station data');
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    print("Error in getAllBikeStations()");
  }
  return [];
}
