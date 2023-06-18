import 'package:flutter/material.dart';
import 'package:client/utility/trips.dart' as trips;

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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadTrips();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _loadTrips() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    final newTrips = await trips.getTravelData(_pageNumber);

    setState(() {
      _trips.addAll(newTrips);
      _pageNumber++;
      _isLoading = false;
    });
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
    return ListView.builder(
      controller: _scrollController,
      itemCount: _trips.length + 1,
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
    );
  }
}
