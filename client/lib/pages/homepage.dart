import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:client/utility/locations.dart' as locations;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final stations = await locations.getAllBikeStations();
    setState(() {
      _markers.clear();
      for (final station in stations) {
        final marker = Marker(
          markerId: MarkerId(station.name),
          position: LatLng(station.latitude, station.longitude),
          infoWindow: InfoWindow(
            title: station.name,
            snippet: station.address,
          ),
        );
        _markers[station.name] = marker;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CityBike'),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.transparent,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(60.16585152619748, 24.931996948918766),
          zoom: 12,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }
}
