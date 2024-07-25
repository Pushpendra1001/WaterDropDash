import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool soundEnabled = true;
  String difficulty = 'Normal';

  void exitApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Exit"),
          content: Text("Do you want to exit?"),
          actions: [
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                SystemNavigator.pop(); // Exit the app
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text('Sound'),
              value: soundEnabled,
              onChanged: (bool value) {
                setState(() {
                  soundEnabled = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text('Difficulty'),
            ListTile(
              title: const Text('Easy'),
              leading: Radio<String>(
                value: 'Easy',
                groupValue: difficulty,
                onChanged: (String? value) {
                  setState(() {
                    difficulty = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Normal'),
              leading: Radio<String>(
                value: 'Normal',
                groupValue: difficulty,
                onChanged: (String? value) {
                  setState(() {
                    difficulty = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Hard'),
              leading: Radio<String>(
                value: 'Hard',
                groupValue: difficulty,
                onChanged: (String? value) {
                  setState(() {
                    difficulty = value!;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  exitApp(context);
                },
                child: Text('Exit Game'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}