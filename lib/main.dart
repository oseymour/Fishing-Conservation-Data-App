import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'models/local_database.dart';


void main() async {
  // Initialize local db
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatabase.instance.initDatabase();

  // Run app
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fishing Conservation Data App',
      home: HomeScreen(),
    );
  }
}