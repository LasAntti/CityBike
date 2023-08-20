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

  Future<void> _selectDateAndTime(bool isDeparture) async {
    final BuildContext context = this.context;

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2021, 5, 1),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );

      if (selectedTime != null) {
        setState(() {
          if (isDeparture) {
            _selectedDepartureDate = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );
          } else {
            _selectedArrivalDate = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );
          }
        });
      }
    }
  }

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
                  ? Text(_selectedDepartureDate.toString().substring(0, 16))
                  : const Text('Select Date and Time'),
              onTap: () {
                _selectDateAndTime(true);
              },
            ),

            // Arrival Date
            ListTile(
              title: const Text('Arrival Date',
                  style: TextStyle(color: Colors.orangeAccent)),
              trailing: _selectedArrivalDate != null
                  ? Text(_selectedArrivalDate.toString().substring(0, 16))
                  : const Text('Select Date and Time'),
              onTap: () {
                _selectDateAndTime(false);
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
                    ? 'Selected Arrival Station: ${stationIdToName[_selectedArrivalStationId]}'
                    : 'Select Arrival Station',
              ),
            ),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Minimum Distance (km)',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _minDistance = (int.tryParse(value));
                  _minDistance = _minDistance! * 1000;
                });
              },
            ),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Minimum Duration (minutes)',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _minDuration = (int.tryParse(value));
                  _minDuration = _minDuration! * 60;
                });
              },
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
                  minDeparture: _selectedDepartureDate,
                  maxDeparture: null,
                  minArrival: _selectedArrivalDate,
                  maxArrival: null,
                  departureStationId: _selectedDepartureStationId,
                  arrivalStationId: _selectedArrivalStationId,
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
