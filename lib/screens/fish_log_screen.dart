import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:grouped_list/grouped_list.dart';

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
    Database db = await LocalDatabase.instance.database;
    // Query catches with oldest first
    final catchMaps = await db.rawQuery('SELECT * FROM Catches ORDER BY datetime ASC');
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

    // Work through catches in reverse order, so most recent catch is on top
    for (var i = _catches.length - 1; i >= 0; i--) {
      CatchEntry c = _catches[i];
      CatchEntryWidget w = CatchEntryWidget(entry: c);
      catchWidgets.add(w);
    }

    // return ListView.builder(
    //   itemCount: _catches.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return CatchEntryWidget(entry: _catches[index]);
    //   },
    // );

    return GroupedListView(
      elements: catchWidgets,
      groupBy: (element) => element.dateString,
      groupSeparatorBuilder: (String groupByValue) => Text(
        groupByValue, 
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontSize: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5).fontSize,
        ),
        textAlign: TextAlign.center,
      ),
      itemBuilder: (BuildContext context, dynamic element) => element,
      order: GroupedListOrder.DESC,
    );
  }
}