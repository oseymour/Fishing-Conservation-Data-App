import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:logger/logger.dart';

import '../models/local_database.dart';
import '../models/catch_entry.dart';
import '../widgets/catch_entry_widget.dart';

var logger = Logger();

class FishLogScreen extends StatefulWidget {
  @override
  State<FishLogScreen> createState() { return _FishLogScreenState(); }
}

class _FishLogScreenState extends State<FishLogScreen> {
  List<CatchEntry> _catches = [];

  Future<void> _getCatches() async {
    final catchMaps = await LocalDatabase.instance.readAllCatches();
    logger.d(sprintf('RETRIEVED %i CATCHES FROM LOCAL DB.', [catchMaps.length]));
    setState(() {
      _catches = catchMaps.map((catchMap) => CatchEntry.fromMap(catchMap)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _getCatches();
  }

  @override
  Widget build(BuildContext context) {
    List<CatchEntryWidget> catchWidgets = [];

    for (var i = 0; i < _catches.length; i++) {
      CatchEntry c = _catches[i];
      CatchEntryWidget w = CatchEntryWidget(entry: c);
      catchWidgets.add(w);
    }

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: catchWidgets
        )
      )
    );
  }
}