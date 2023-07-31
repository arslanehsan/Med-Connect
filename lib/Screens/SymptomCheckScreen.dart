import 'package:flutter/material.dart';

import '../Utils/Router.dart';

class SymptomCheckScreen extends StatefulWidget {
  const SymptomCheckScreen({super.key});

  @override
  _SymptomCheckScreenState createState() => _SymptomCheckScreenState();
}

class _SymptomCheckScreenState extends State<SymptomCheckScreen> {
  List<String> selectedSymptoms = [];

  void _toggleSymptom(String symptom) {
    setState(() {
      if (selectedSymptoms.contains(symptom)) {
        selectedSymptoms.remove(symptom);
      } else {
        selectedSymptoms.add(symptom);
      }
    });
  }

  void _checkSymptoms() {
    RouterClass().symptomsAccordingDoctorScreenRoute(context: context);
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       title: const Text('Selected Symptoms'),
    //       content: Text(selectedSymptoms.join(", ")),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: const Text('Close'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Symptom Checker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select your symptoms:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSymptomCheckbox('Fever'),
            _buildSymptomCheckbox('Cough'),
            _buildSymptomCheckbox('Headache'),
            _buildSymptomCheckbox('Sore Throat'),
            // Add more symptom checkboxes as needed
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: selectedSymptoms.isEmpty ? null : _checkSymptoms,
              child: const Text('Check Symptoms'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSymptomCheckbox(String symptom) {
    return CheckboxListTile(
      title: Text(symptom),
      value: selectedSymptoms.contains(symptom),
      onChanged: (value) {
        _toggleSymptom(symptom);
      },
    );
  }
}
