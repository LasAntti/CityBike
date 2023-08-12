import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TravelData {
  int id;
  DateTime? departureTime;
  DateTime? arrivalTime;
  int departureStationId;
  String departureStationName;
  int arrivalStationId;
  String arrivalStationName;
  int distanceCoveredInMeters;
  int durationInSeconds;

  TravelData({
    required this.id,
    String? departureTime,
    String? arrivalTime,
    required this.departureStationId,
    required this.departureStationName,
    required this.arrivalStationId,
    required this.arrivalStationName,
    required this.distanceCoveredInMeters,
    required this.durationInSeconds,
  }) {
    this.departureTime = departureTime != null ? DateTime.parse(departureTime) : null;
    this.arrivalTime = arrivalTime != null ? DateTime.parse(arrivalTime) : null;
  }
}

Future<List<TravelData>> getTravelData(int pageNumber) async {
  try {
    final url =
        Uri.parse('http://${dotenv.env['IP_ADDRESS']}:8080/allTravelData?page=$pageNumber');

    final response = await http.get(
      url,
      headers: {
        'Accept-Charset':
            'utf-8', // Without this header, all names containing Å, Ä or Ö are not shown correctly
      },
    );

    if (response.statusCode == 200) {
      final jsonData = utf8.decode(response.bodyBytes);
      final dynamicData = jsonDecode(jsonData) as List<dynamic>;
      List<TravelData> trips = [];

      for (var data in dynamicData) {
        TravelData trip = TravelData(
          id: data['id'] as int,
          departureTime: data['departure'] as String,
          arrivalTime: data['arrival'] as String,
          departureStationId: data['departureStationId'] as int,
          departureStationName: data['departureStationName'] as String,
          arrivalStationId: data['arrivalStationId'] as int,
          arrivalStationName: data['arrivalStationName'] as String,
          distanceCoveredInMeters: data['distanceCoveredinMeters'] as int,
          durationInSeconds: data['durationInSeconds'] as int,
        );
        
        trips.add(trip);
      }
      return trips;
    } else {
      throw Exception('Failed to fetch station data');
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    print("Error in getTravelData()");
  }
  return [];
}

Future<List<TravelData>> getFilteredTravelData({
  int? pageNumber,
  DateTime? minDeparture,
  DateTime? maxDeparture,
  DateTime? minArrival,
  DateTime? maxArrival,
  int? departureStationId,
  int? arrivalStationId,
  int? minDistance,
  int? maxDistance,
  int? minDuration,
  int? maxDuration,
}) async {
  try {
    final url = Uri.parse('http://${dotenv.env['IP_ADDRESS']}:8080/searchTrips');

    final response = await http.get(
      url.replace(queryParameters: {
        'page': pageNumber?.toString() ?? '0',
        'minDeparture': minDeparture?.toIso8601String() ?? '',
        'maxDeparture': maxDeparture?.toIso8601String() ?? '',
        'minArrival': minArrival?.toIso8601String() ?? '',
        'maxArrival': maxArrival?.toIso8601String() ?? '',
        'departureStationId': departureStationId?.toString() ?? '',
        'arrivalStationId': arrivalStationId?.toString() ?? '',
        'minDistance': minDistance?.toString() ?? '',
        'maxDistance': maxDistance?.toString() ?? '',
        'minDuration': minDuration?.toString() ?? '',
        'maxDuration': maxDuration?.toString() ?? '',
      }),
      headers: {
        'Accept-Charset': 'utf-8', // Without this header, all names containing Å, Ä or Ö are not shown correctly
      },
    );

    if (response.statusCode == 200) {
      final jsonData = utf8.decode(response.bodyBytes);
      final dynamicData = jsonDecode(jsonData) as List<dynamic>;
      List<TravelData> trips = [];

      for (var data in dynamicData) {
        TravelData trip = TravelData(
          id: data['id'] as int,
          departureTime: data['departure'] as String,
          arrivalTime: data['arrival'] as String,
          departureStationId: data['departureStationId'] as int,
          departureStationName: data['departureStationName'] as String,
          arrivalStationId: data['arrivalStationId'] as int,
          arrivalStationName: data['arrivalStationName'] as String,
          distanceCoveredInMeters: data['distanceCoveredinMeters'] as int,
          durationInSeconds: data['durationInSeconds'] as int,
        );
        
        trips.add(trip);
      }
      return trips;
    } else {
      throw Exception('Failed to fetch station data');
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    print("Error in getFilteredTravelData()");
  }
  return [];
}