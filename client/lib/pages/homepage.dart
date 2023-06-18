import 'package:client/widgets/trips_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:client/utility/locations.dart' as locations;
import 'package:client/widgets/search_widget.dart';
import '../utility/locations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, Marker> _markers = {};
  late GoogleMapController _mapController;
  bool _showMarkers = false;
  int _selectedIndex = 0;
  List<Station> _stations = [];
  List<Station> _filteredStations = [];

  @override
  void initState() {
    super.initState();
    _loadStations();
  }

  Future<void> _loadStations() async {
    _stations = await locations.getAllBikeStations();
    _filteredStations =
        _stations.toList(); // Initialize filtered stations with all stations
    _updateMarkers();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    _updateMarkers();
  }

  void _updateMarkers() {
    setState(() {
      _markers.clear();
      for (final station in _filteredStations) {
        final marker = Marker(
          markerId: MarkerId(station.nimi),
          position: LatLng(station.latitude, station.longitude),
          infoWindow: InfoWindow(
            title: station.name,
            snippet: station.address,
          ),
          visible: _showMarkers,
        );
        _markers[station.nimi] = marker;
      }
    });
  }

  void _onSearchTextChanged(String searchText) {
    setState(() {
      _filteredStations = _stations
          .where((station) =>
              station.name!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      _updateMarkers();
    });
  }

  void _toggleMarkersVisibility() {
    setState(() {
      _showMarkers = !_showMarkers;
      _markers.forEach((key, marker) {
        _markers[key] = marker.copyWith(visibleParam: _showMarkers);
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleShowOnMap(int stationId) {
    final station = _stations.firstWhere((station) => station.id == stationId);
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(station.latitude, station.longitude),
          zoom: 14,
        ),
      ),
    );
    _mapController.showMarkerInfoWindow(MarkerId(station.nimi));
    _onItemTapped(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CityBike'),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            color: Colors.orangeAccent,
            onPressed: _toggleMarkersVisibility,
            icon: _showMarkers
                ? const Icon(Icons.location_on_outlined)
                : const Icon(Icons.location_off_outlined),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(60.16585152619748, 24.931996948918766),
              zoom: 12,
            ),
            markers: _markers.values.toSet(),
          ),
          const TripWidget(),
          ListView.builder(
            itemCount: _filteredStations.length,
            itemBuilder: (context, index) {
              final station = _filteredStations[index];

              return ListTile(
                title: Text(station.nimi),
                subtitle: Text(station.address),
                onTap: () {
                  _handleShowOnMap(station.id);
                },
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        backgroundColor: Colors.transparent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore_outlined),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Station List',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: SearchBarWidget(
              onSearchTextChanged: _onSearchTextChanged,
              stations: _stations,
              onStationSelected: _handleShowOnMap,
            ),
          );
        },
        backgroundColor: Colors.orangeAccent,
        child: const Icon(Icons.search),
      ),
    );
  }
}
