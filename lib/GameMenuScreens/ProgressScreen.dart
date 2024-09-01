import 'package:flutter/material.dart';
import 'package:waterdropdash/GameMenuScreens/BadgeScreen.dart';
import 'package:waterdropdash/GameMenuScreens/CommingSoon.dart';
import 'package:waterdropdash/GameMenuScreens/DailyChallengePage.dart';

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF001C38),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Text(
              'Progress',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  _buildProgressItem('Badges', 'badgeLogo.png', onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BadgesScreen()));
                  }),
                  _buildProgressItem('Daily Challenge', 'dailyChallenge.png' , onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DailyChallengeScreen()));
                  
                  },),
                  _buildProgressItem('Hydro Quests', 'hydroQuests.png' , onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Commingsoon()));
                  
                  },),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressItem(String title, String iconName, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(16),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset('assets/$iconName', height: 200),
               
              ],
            ),

          ],
        ),
      ),
    );
  }
}