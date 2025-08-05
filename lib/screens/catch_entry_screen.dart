import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:date_field/date_field.dart';
import 'package:sprintf/sprintf.dart';
import 'package:uuid/uuid.dart';
import 'package:logger/logger.dart';

import '../models/catch_entry.dart';
import '../models/local_database.dart';

var uuidGenerator = Uuid();

class CatchEntryScreen extends StatefulWidget {
  @override
  State<CatchEntryScreen> createState() { return _CatchEntryScreenState(); }
}

class _CatchEntryScreenState extends State<CatchEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final lengthController = TextEditingController();
  final weigthController = TextEditingController();
  final girthController = TextEditingController();
  DateTime? selectedDateTime;

  Future<int> _insertCatch(CatchEntry entry) async {
    return LocalDatabase.instance.insertCatch(entry);
  }

  @override
  void dispose () {
    // Clean up all controllers when widget is disposed
    lengthController.dispose();
    weigthController.dispose();
    girthController.dispose();
    super.dispose();
  }

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
            },
            controller: lengthController,
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
            },
            controller: weigthController,
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: 'Girth to nearest 1/4 in. (optional)'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [ 
              FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d*)?')),
            ],
            controller: girthController,
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
            child: const Text('SAVE'),
            onPressed: () {
              if ( _formKey.currentState!.validate() ) {
                // Form is valid
                CatchEntry entry = CatchEntry(
                  uuid: uuidGenerator.v4(),
                  length: double.parse(lengthController.text),
                  weight: double.parse(weigthController.text),
                  girth: double.tryParse(girthController.text),
                  datetime: selectedDateTime!.millisecondsSinceEpoch,
                );
                logger.d(sprintf('FORM IS VALID. INSERTING INTO LOCAL DATABASE %s', [entry]));

                // Insert into local DB
                _insertCatch(entry);
              } else {
                // Form is invalid
                logger.e('INVALID FORM.');
              }
            },
          ),
        ],
      )
    );
  }
}