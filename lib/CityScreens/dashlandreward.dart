import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterdropdash/GameMenuScreens/GameLevelScreen.dart';
import 'package:waterdropdash/MainGameScreens/MainGame.dart';
import 'package:waterdropdash/provider/GameState.dart';
import 'dart:math';

class Dashlandreward extends StatelessWidget {
  final int rewardAmount;
  final String badgeName;
  
  final Random _random = Random();

  Dashlandreward({required this.rewardAmount, this.badgeName = '', });

  bool _shouldAwardBadge() {
    return _random.nextDouble() < 1; // 5% chance
  }

  String _getRandomBadge() {
    int badgeNumber = _random.nextInt(12) + 1; // Random number between 1 and 12
    return 'cb$badgeNumber';
  }

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    final awardedBadge = _shouldAwardBadge() ? _getRandomBadge() : '';

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
                  Image.asset('assets/images/dash1.png', height: 100),
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
                  if (awardedBadge.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Image.asset('assets/aabadges/$awardedBadge.png', height: 200),
                          Text('You earned a new badge!', style: TextStyle(fontSize: 18, color: Colors.green)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                
                gameState.increaseMainGameScore(rewardAmount);
                if (awardedBadge.isNotEmpty) {
                  gameState.unlockBadge(awardedBadge);
                }
                Navigator.pop(context);
              },
              child: Text("Collect"),
            )
          ],
        ),
      ),
    );
  }
}