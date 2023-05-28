import 'package:flutter/material.dart';



class SearchBarWidget extends StatelessWidget {
  final Function(String) onSearchTextChanged;

  const SearchBarWidget({required this.onSearchTextChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onSearchTextChanged,
      decoration: const InputDecoration(
        hintText: 'Search by name',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
