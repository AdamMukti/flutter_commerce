import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('FilterChip Example'),
        ),
        body: FilterChipExample(),
      ),
    );
  }
}

class FilterChipExample extends StatefulWidget {
  @override
  _FilterChipExampleState createState() => _FilterChipExampleState();
}

class _FilterChipExampleState extends State<FilterChipExample> {
  List<String> selectedFilters = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: List<Widget>.generate(
            filterOptions.length,
            (int index) {
              return FilterChip(
                label: Text(filterOptions[index]),
                selected: selectedFilters.contains(filterOptions[index]),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      selectedFilters.add(filterOptions[index]);
                    } else {
                      selectedFilters.remove(filterOptions[index]);
                    }
                  });
                },
              );
            },
          ),
        ),
        SizedBox(height: 20),
        Text('Selected Filters: ${selectedFilters.join(', ')}'),
      ],
    );
  }
}

final List<String> filterOptions = [
  'Option A',
  'Option B',
  'Option C',
  'Option D',
  'Option E',
];
