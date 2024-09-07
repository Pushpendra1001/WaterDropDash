import 'package:flutter/material.dart';
import 'package:waterdropdash/GameMenuScreens/ScannerScreen.dart';

class WaterTargetScreen extends StatelessWidget {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('0.0 L', style: TextStyle(color: Colors.red)),
                  Text('1.5 L', style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                child: Text('Drink Water' , style: TextStyle(color: Colors.white),),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BottleScannerGame()));
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