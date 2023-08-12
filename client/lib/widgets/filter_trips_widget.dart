import 'package:flutter/material.dart';
import 'package:client/utility/locations.dart' as locations;
import 'package:client/widgets/search_widget.dart';

import '../utility/locations.dart';

class TripFilterWidget extends StatefulWidget {
  final void Function({
    DateTime? minDeparture,
    DateTime? maxDeparture,
    DateTime? minArrival,
    DateTime? maxArrival,
    int? departureStationId,
    int? arrivalStationId,
    int? minDistance,
    int? minDuration,
  }) onFilter;

  const TripFilterWidget({Key? key, required this.onFilter}) : super(key: key);

  @override
  _TripFilterWidgetState createState() => _TripFilterWidgetState();
}

class _TripFilterWidgetState extends State<TripFilterWidget> {
  DateTime? _minDeparture;
  DateTime? _maxDeparture;
  DateTime? _minArrival;
  DateTime? _maxArrival;
  DateTime? _selectedDepartureDate;
  DateTime? _selectedArrivalDate;
  int? _departureStationId;
  int? _selectedDepartureStationId;
  int? _selectedArrivalStationId;
  int? _arrivalStationId;
  int? _minDistance;
  int? _minDuration;
  List<Station> _stations = [];
  Map<int, String> stationIdToName = {};

  @override
  void initState() {
    super.initState();
    _loadStations();
  }

  void _handleStationSelection(int stationId, bool isDeparture) {
    if (isDeparture) {
      setState(() {
        _selectedDepartureStationId = stationId;
        stationIdToName[stationId] =
            _stations.firstWhere((station) => station.id == stationId).name!;
      });
    } else {
      setState(() {
        _selectedArrivalStationId = stationId;
        stationIdToName[stationId] =
            _stations.firstWhere((station) => station.id == stationId).name!;
      });
    }
  }

  Future<void> _loadStations() async {
    _stations = await locations.getAllBikeStations();
  }

  // Implement the UI for user input controls (date pickers, sliders, etc.)
  // and update the state variables (_minDeparture, _maxDeparture, etc.)
  // based on user interactions.

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Filter Trips',
        style: TextStyle(color: Colors.orangeAccent),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Departure Date
            ListTile(
              title: const Text('Departure Date',
                  style: TextStyle(color: Colors.orangeAccent)),
              trailing: _selectedDepartureDate != null
                  ? Text(_selectedDepartureDate.toString())
                  : const Text('Select Date'),
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2021, 5, 1),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (selectedDate != null) {
                  setState(() {
                    _selectedDepartureDate = selectedDate;
                  });
                }
              },
            ),

            // Arrival Date
            ListTile(
              title: const Text('Arrival Date',
                  style: TextStyle(color: Colors.orangeAccent)),
              trailing: _selectedArrivalDate != null
                  ? Text(_selectedArrivalDate.toString())
                  : const Text('Select Date'),
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2021, 8, 31),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (selectedDate != null) {
                  setState(() {
                    _selectedArrivalDate = selectedDate;
                  });
                }
              },
            ),
            
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchBarWidget(
                    onSearchTextChanged: (query) {},
                    stations: _stations,
                    onStationSelected: (stationId) {
                      _handleStationSelection(
                          stationId, true); // Pass true for departure station
                    },
                  ),
                );
              },
              child: Text(
                _selectedDepartureStationId != null
                    ? 'Selected Departure Station: ${stationIdToName[_selectedDepartureStationId]}'
                    : 'Select Departure Station',
              ),
            ),

            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchBarWidget(
                    onSearchTextChanged: (query) {},
                    stations: _stations,
                    onStationSelected: (stationId) {
                      _handleStationSelection(
                          stationId, false); // Pass false for arrival station
                    },
                  ),
                );
              },
              child: Text(
                _selectedArrivalStationId != null
                    ? 'Selected Departure Station: ${stationIdToName[_selectedArrivalStationId]}'
                    : 'Select Departure Station',
              ),
            ),

            const SizedBox(height: 50),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: () {
                //Apply selected filters using the widget.onFilter callback
                widget.onFilter(
                  minDeparture: _minDeparture,
                  maxDeparture: _maxDeparture,
                  minArrival: _minArrival,
                  maxArrival: _maxArrival,
                  departureStationId: _departureStationId,
                  arrivalStationId: _arrivalStationId,
                  minDistance: _minDistance,
                  minDuration: _minDuration,
                );
                Navigator.pop(context); 
              },
              child: const Text('Apply Filters'),
            ),
          ],
        ),
      ),
    );
  }
}
