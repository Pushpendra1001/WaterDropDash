import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterdropdash/provider/GameState.dart';

class BadgesScreen extends StatelessWidget {
  final List<String> badges = List.generate(12, (index) => 'cb${index + 1}');

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);

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
              'Badges',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 25),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: badges.length,
                itemBuilder: (context, index) {
                  String badgeName = badges[index];
                  return Column(
                    children: [
                      Image.asset(
                        gameState.isBadgeUnlocked(badgeName)
                          ? 'assets/Colorfullbades/$badgeName.png'
                          : 'assets/noachievedBadges/$badgeName.png',
                        height: 80,
                      ),
                      SizedBox(height: 8),
                      Text(
                        gameState.isBadgeUnlocked(badgeName) ? 'Unlocked' : 'Locked',
                        style: TextStyle(
                          color: gameState.isBadgeUnlocked(badgeName) ? Colors.green : Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}