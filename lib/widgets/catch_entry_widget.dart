import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import '../models/catch_entry.dart';

class CatchEntryWidget extends StatelessWidget {
  final CatchEntry entry;
  
  CatchEntryWidget({required this.entry});

  // Parse UNIX time from sqlite db into datetime object
  DateTime get dt => DateTime.fromMillisecondsSinceEpoch(entry.datetime);

  // Used for grouping catches on the log screen
  String get dateString => sprintf(
    '%i-%s-%s', 
    [dt.year, dt.month.toString().padLeft(2, '0'), dt.day.toString().padLeft(2, '0')]
  );

  // Make datetime string to display in widget
  String get dateTimeString => sprintf(
    '%i-%s-%s %i:%s', 
    [
      dt.year, 
      dt.month.toString().padLeft(2, '0'), 
      dt.day.toString().padLeft(2, '0'), 
      dt.hour, 
      dt.minute.toString().padLeft(2, '0')
    ]
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: BoxBorder.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            sprintf('Length: %s in.', [entry.length.toStringAsFixed(2)]), 
            textAlign: TextAlign.left,
          ),
          Text(
            sprintf('Weight: %s lbs', [entry.weight.toStringAsFixed(2)]), 
            textAlign: TextAlign.left,
          ),
          Text(
            sprintf('Girth: %s in.', [entry.girth?.toStringAsFixed(2) ?? '-']), 
            textAlign: TextAlign.left,
          ),
          Text(
            sprintf('Date: %s', [dateTimeString]), 
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}