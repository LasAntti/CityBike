import 'package:flutter/material.dart';
import 'package:client/utility/trips.dart' as trips;
import 'package:client/widgets/filter_trips_widget.dart';

class TripWidget extends StatefulWidget {
  const TripWidget({Key? key}) : super(key: key);

  static const String routeName = '/trips';

  @override
  State<TripWidget> createState() => _TripWidgetState();
}

class _TripWidgetState extends State<TripWidget> {
  final List<trips.TravelData> _trips = [];
  int _pageNumber = 0;
  bool _isLoading = false;

  DateTime? _minDeparture;
  DateTime? _maxDeparture;
  DateTime? _minArrival;
  DateTime? _maxArrival;
  int? _departureStationId;
  int? _arrivalStationId;
  int? _minDistance;
  int? _minDuration;
  int? _totalElements;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadTrips();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _loadTrips({bool clearList = false}) async {
  if (_isLoading) return;

  setState(() {
    _isLoading = true;
  });

  if (clearList) {
    setState(() {
      _trips.clear();
      _pageNumber = 0;
    });
  }

  final result = await trips.getFilteredTravelData(
    pageNumber: _pageNumber,
    departureStationId: _departureStationId,
    arrivalStationId: _arrivalStationId,
    minDeparture: _minDeparture,
    maxDeparture: _maxDeparture,
    minArrival: _minArrival,
    maxArrival: _maxArrival,
    minDistance: _minDistance,
    minDuration: _minDuration,
  );

  final newTrips = result['trips'] as List<trips.TravelData>;
  final totalElements = result['totalElements'] as int;

   
  final filteredTrips = newTrips.where((trip) => trip.departureTime != null).toList();

  
   filteredTrips.sort((a, b) => b.departureTime!.compareTo(a.departureTime!));

  setState(() {
    _trips.addAll(filteredTrips);
    _totalElements = totalElements;
    _pageNumber++;
    _isLoading = false;
  });

  print('New Trips Count: ${newTrips.length}');
  print('Total Trips Count: $totalElements');
}


  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadTrips();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _trips.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _trips.length) {
            final trip = _trips[index];

            return ExpansionTile(
              title: Text(trip.departureTime.toString().substring(0, 19)),
              children: [
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          'Departure: ${trip.departureTime.toString().substring(0, 19)}'),
                      Text(
                          'Arrival: ${trip.arrivalTime.toString().substring(0, 19)}'),
                      Text(
                          'Duration: ${(trip.durationInSeconds / 60).toStringAsFixed(2)} minutes || Distance: ${(trip.distanceCoveredInMeters / 1000).toStringAsFixed(2)} km'),
                      Text('Departure station: ${trip.departureStationName}'),
                      Text('Arrival station: ${trip.arrivalStationName}'),
                    ],
                  ),
                ),
              ],
            );
          } else if (_isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'search_fab_trips',
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return TripFilterWidget(
                onFilter: ({
                  DateTime? minDeparture,
                  DateTime? maxDeparture,
                  DateTime? minArrival,
                  DateTime? maxArrival,
                  int? departureStationId,
                  int? arrivalStationId,
                  int? minDistance,
                  int? minDuration,
                }) {
                  setState(() {
                    _minDeparture = minDeparture;
                    _maxDeparture = maxDeparture;
                    _minArrival = minArrival;
                    _maxArrival = maxArrival;
                    _departureStationId = departureStationId;
                    _arrivalStationId = arrivalStationId;
                    _minDistance = minDistance;
                    _minDuration = minDuration;
                  });

                  _loadTrips(clearList: true);
                },
              );
            },
          );
        },
        backgroundColor: Colors.orangeAccent,
        label:  _totalElements != null ? Text('Filter trips ($_totalElements results)') : const Text('Filter trips'),
        icon: const Icon(Icons.travel_explore_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
