import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterdropdash/GameMenuScreens/ScannerScreen.dart';
import 'package:waterdropdash/provider/GameState.dart';

class WaterTargetScreen extends StatefulWidget {
  @override
  _WaterTargetScreenState createState() => _WaterTargetScreenState();
}

class _WaterTargetScreenState extends State<WaterTargetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      backgroundColor: const Color(0xFF001C38),
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Daily Challenge',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/humanwaterintake.png',
                    color: Colors.blue.withOpacity(0.1),
                    colorBlendMode: BlendMode.srcATop,
                  ),
                ],
              ),
            ),
            Consumer<GameState>(
              builder: (context, gameState, child) {
                return Text(
                  '${gameState.waterConsumed.toStringAsFixed(1)} L',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('0.0 L', style: TextStyle(color: Colors.red)),
                  Text('2.5 L', style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Consumer<GameState>(
                builder: (context, gameState, child) {
                  return LinearProgressIndicator(
                    value: gameState.waterConsumed / 2.5, // Progress value between 0.0 and 1.0
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                    minHeight: 10,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                child: Text(
                  'Drink Water',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // Simulate drinking water by adding 0.1L
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BottleScannerGame()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF001C38),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}