import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Station {
  int id;
  String nimi;
  String? name;
  String? namn;
  String address;
  double latitude;
  double longitude;
  int capacity;
  String kaupunki;
  String stad;

  Station({
    required this.id,
    required this.nimi,
    this.name,
    this.namn,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.capacity,
    required this.kaupunki,
    required this.stad,
  });
}

Future<List<Station>> getAllBikeStations() async {
  try {
    final url = Uri.parse('http://${dotenv.env['IP_ADDRESS']}:8080/allStationData');

    final response = await http.get(
      url,
      headers: {
        'Accept-Charset': 'utf-8', // Without this header, all names containing å, ä or ö are not shown correctly
      },
    );

    if (response.statusCode == 200) {
      final jsonData = utf8.decode(response.bodyBytes); 
      final dynamicData = jsonDecode(jsonData) as List<dynamic>;
      List<Station> stations = [];

      for (var data in dynamicData) {
        if (data['lat'] != null && data['lon'] != null) {
          Station station = Station(
            id: data['id'] as int,
            nimi: data['nimi'] as String,
            name: data['name'] as String,
            namn: data['namn'] as String,
            address: data['osoite'] as String,
            latitude: data['lat'] as double,
            longitude: data['lon'] as double,
            capacity: data['capacity'] as int,
            kaupunki: data['kaupunki'] as String,
            stad: data['stad'] as String,
          );
          stations.add(station);
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

