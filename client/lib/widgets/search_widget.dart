import 'package:client/utility/locations.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends SearchDelegate<Station> {
  final Function(String) onSearchTextChanged;
  final List<Station> stations;
  final Function(int)? onStationSelected;

  SearchBarWidget(
      {required this.onSearchTextChanged,
      required this.stations,
      required this.onStationSelected});

  List<Station> _getResults() {
    return stations
        .where((station) =>
            station.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  List<Station> _getSuggestions() {
    stations.sort((a, b) => a.nimi.compareTo(b.nimi));
    return stations
        .where((station) =>
            station.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void _handleShowOnMap(int stationId) {
    if (onStationSelected != null) {
      onStationSelected!(stationId);
    }
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, stations.first);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = _getSuggestions();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ExpansionTile(
          title: Text(suggestion.nimi),
          children: [
            ListTile(
              title: Column(
                children: [
                  Text('${suggestion.kaupunki} || ${suggestion.stad}'),
                  Text(suggestion.address),
                  Text(suggestion.namn ?? 'Swedish name missing'),
                  Text("Capacity: ${suggestion.capacity}"),
                  Text("Station ID: ${suggestion.id}"),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.orangeAccent),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _handleShowOnMap(suggestion.id);
                      close(context, suggestion);
                    },
                    child: const Text("Select station"),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = _getResults();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];

        return ExpansionTile(
          title: Text(result.nimi),
          children: [
            ListTile(
              title: Column(
                children: [
                  Text('${result.kaupunki} || ${result.stad}'),
                  Text(result.address),
                  Text(result.namn ?? 'Swedish name missing'),
                  Text("Capacity: ${result.capacity}"),
                  Text("Station ID: ${result.id}"),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.orangeAccent),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _handleShowOnMap(result.id);
                      close(context, result);
                    },
                    child: const Text("Show on map"),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear search query
        },
      ),
    ];
  }
}
