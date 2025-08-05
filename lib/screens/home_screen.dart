import 'package:flutter/material.dart';

import 'catch_entry_screen.dart';
import 'fish_log_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() { return _HomeScreenState(); }
}


class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = CatchEntryScreen();
      case 1:
        page = FishLogScreen();
      case 2:
        page = Placeholder(color: Colors.blue);
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      appBar: AppBar(title: Text('Fishing Conservation Data App')),
      body: page,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) { 
          setState(() { selectedIndex = index; } ); 
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_add),
            label: 'New Entry',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Fish Log'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync),
            label: 'Sync Status',
          ),
        ]
      ),
    );
  }
}