import 'package:flutter/material.dart';
import 'package:client/utility/locations.dart';

class StationListWidget extends StatelessWidget {
  final List<Station> stations;
  final Function(int)? onStationSelected;

  const StationListWidget(
      {super.key, required this.stations, this.onStationSelected});

  void _handleShowOnMap(int stationId) {
    if (onStationSelected != null) {
      onStationSelected!(stationId);
    }
  }

  @override
  Widget build(BuildContext context) {
    stations.sort((a, b) => a.nimi.compareTo(b.nimi));
    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (context, index) {
        final station = stations[index];
        if (station.kaupunki == " " && station.stad == " ") {
          station.kaupunki = "Helsinki";
          station.stad = "Helsingfors";
        }

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
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.orangeAccent)
                          )
                        )
                      ),
                      onPressed: () {
                        _handleShowOnMap(station.id);
                      },
                      child: const Text("Show on map")),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
