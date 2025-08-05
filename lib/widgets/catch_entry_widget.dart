import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import '../models/catch_entry.dart';

class CatchEntryWidget extends StatelessWidget {
  final CatchEntry entry;
  
  CatchEntryWidget({required this.entry});

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
            sprintf('Date: %s', [DateTime.fromMillisecondsSinceEpoch(entry.datetime)]), 
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}