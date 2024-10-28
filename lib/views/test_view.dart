import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class MyListView extends StatelessWidget {
  final List<Map<String, String>> yourList = [
    {'value1': 'John', 'value2': 'Doe', 'value3': '35'},
    {'value1': 'Jane', 'value2': 'Smith', 'value3': '28'},
    {'value1': 'Paul', 'value2': 'Johnson', 'value3': '42'},
    {'value1': 'Emily', 'value2': 'Davis', 'value3': '30'},
    {'value1': 'Michael', 'value2': 'Brown', 'value3': '22'},
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(label: Text('Title 1')),
          DataColumn(label: Text('Title 2')),
          DataColumn(label: Text('Title 3')),
        ],
        rows: yourList.map((item) {
          return DataRow(
          cells: <DataCell>[
          DataCell(Text(item['value1']!)),
          DataCell(Text(item['value2']!)),
          DataCell(Text(item['value3']!)),
          ],
          );
        }).toList(),
      ),
    );
  }

}
