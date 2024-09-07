import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterdropdash/MainGameScreens/RewardScreen.dart';
import 'package:waterdropdash/MainGameScreens/MainGame.dart';
import 'package:waterdropdash/provider/GameState.dart';


class Gameplayingscreen extends StatelessWidget {
   Gameplayingscreen({super.key, required this.currentLevel, required this.waterBottleTarget});

  final int currentLevel;
  final int waterBottleTarget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget<DashGame>(
        game: DashGame(currentLevel: currentLevel, waterBottleTarget: waterBottleTarget),
        overlayBuilderMap: {
          'gameOver': (context, game) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Game Over', style: TextStyle(fontSize: 48, color: Colors.white)),
                ElevatedButton(
                  child: Text('Try Again'),
                  onPressed: () {
                    game.reset();
                    game.overlays.remove('gameOver');
                  },
                ),
              ],
            ),
          ),
              'levelComplete': (context, game) => Center(
        
          ),
          'rewardScreen': (context, game) => RewardScreen(game: game as DashGame, rewardAmount: waterBottleTarget, ),
        },
      )
    );
  }
}