import 'package:flutter/material.dart';
import 'package:client/utility/locations.dart';

class StationListWidget extends StatelessWidget {
  final List<Station> stations;

  const StationListWidget({required this.stations});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (context, index) {
        final station = stations[index];
        return ExpansionTile(
          title: Text(station.nimi),
          children: [
           ListTile(
            title: Column(
              children: [
                Text('${station.kaupunki} || ${station.stad}'),
                Text(station.address),
                Text(station.namn ?? 'Swedish name missing'),
                Text("Capacity: ${station.capacity}"),
                Text("Station ID: ${station.id}"),    
              ],
            ),
          ),
          ],
        );
      },
    );
  }
}
