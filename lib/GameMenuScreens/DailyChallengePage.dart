import 'package:flutter/material.dart';
import 'package:waterdropdash/GameMenuScreens/WaterTargetScreen.dart';
import 'package:waterdropdash/MainGameScreens/WaterIntakeScreen.dart';

class DailyChallengeScreen extends StatelessWidget {
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
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundImage: AssetImage('assets/images/water.png'),
                        ),
                        SizedBox(width: 8),
                       
                      ],
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
            Spacer(),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text(  'YOUR PROFILE', style: TextStyle(color: Colors.orange , fontSize: 26))),
                  Text(  'Gender: Male' , style: TextStyle(fontSize: 20),),
                  Text(  'Age: xx' , style: TextStyle(fontSize: 20),),
                  SizedBox(height: 10, ),
                  Text(  'STATUS:', style: TextStyle(color: Colors.orange , fontSize: 20)),
                  Text(  'You are doing great! Keep it up!' , style: TextStyle(fontSize: 20),),
                
                ],
              ),
            ),
            Spacer(),
                      
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                child: Text('Recommend'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WaterTargetScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  
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