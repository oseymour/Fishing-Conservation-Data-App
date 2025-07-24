import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:date_field/date_field.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fishing Conservation Data App',
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() { return _HomePageState(); }
}


class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = NewEntryPage();
      case 1:
        page = Placeholder(color: Colors.green);
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
            label: 'Entries'
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


class NewEntryPage extends StatefulWidget {
  @override
  State<NewEntryPage> createState() { return _NewEntryPageState(); }
}


class _NewEntryPageState extends State<NewEntryPage> {
  double length = -1.0;
  double weight = -1.0;
  double girth = -1.0;
  DateTime? selectedDateTime;
  var location;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(hintText: 'Length to nearest 1/4 in.'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [ 
              FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d*)?')),
            ],
            validator: (value) {
              if ( value == null || value.isEmpty ) {
                return 'Enter a number.';
              }
              return null;
            }
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: 'Weight in lbs.'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [ 
              FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d*)?')),
            ],
            validator: (value) {
              if ( value == null || value.isEmpty ) {
                return 'Enter a number.';
              }
              return null;
            }
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: 'Girth to nearest 1/4 in. (optional)'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [ 
              FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d*)?')),
            ],
          ),
          DateTimeFormField(
            decoration: const InputDecoration(labelText: 'Enter Date and Time'),
            firstDate: DateTime(2000),
            lastDate: DateTime(3000),
            initialPickerDateTime: DateTime.now(),
            onChanged: (DateTime? value) { selectedDateTime = value; },
            validator: (value) {
              if ( value == null ) {
                return 'Enter a date and time.';
              }
              return null;
            }
          ),
          ElevatedButton(
            child: const Text('Submit'),
            onPressed: () {
              if ( _formKey.currentState!.validate() ) {
                // Form is valid
                print('Form is valid');
              } else {
                print('INVALID form.');
              }
            },
          ),
        ],
      )
    );
  }
}
