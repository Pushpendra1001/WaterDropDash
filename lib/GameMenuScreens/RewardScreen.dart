import 'package:flutter/material.dart';
import 'package:waterdropdash/GameMenuScreens/GameLevelScreen.dart';
import 'package:waterdropdash/MainGameScreens/MainGame.dart';

class RewardScreen extends StatelessWidget {
  final int rewardAmount;
  final String badgeName;

  RewardScreen({required this.rewardAmount, this.badgeName = '', required DashGame game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Well-done!',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  SizedBox(height: 20),
                  Image.asset('assets/images/dash.png', height: 100),
                  SizedBox(height: 20),
                  Text(
                    'REWARD',
                    style: TextStyle(fontSize: 18, color: Colors.orange),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$rewardAmount',
                        style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      Image.asset('assets/images/water.png', height: 40),
                    ],
                  ),
                  Text(
                    'EARNED',
                    style: TextStyle(fontSize: 18, color: Colors.orange),
                  ),
                  if (badgeName.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Image.asset('assets/badges/$badgeName.png', height: 80),
                    ),
                ],
              ),
            ),

            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => GameLevelScreen(),));
            }, child: Text("Next Level"))
          ],
        ),
      ),
    );
  }
}