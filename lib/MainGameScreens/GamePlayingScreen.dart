import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:waterdropdash/MainGameScreens/MainGame.dart';

class Gameplayingscreen extends StatelessWidget {
   Gameplayingscreen({super.key , required this.currentLevel , required this.waterBottleTarget});

  int currentLevel ;
  int waterBottleTarget ;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       body: GameWidget<DashGame>(
      game: DashGame(currentLevel: currentLevel , waterBottleTarget: waterBottleTarget),
      overlayBuilderMap: {
        'gameOver': (context, game) => Center(
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Game Over',
                  style: TextStyle(fontSize: 48, color: Colors.white),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Try Again'),
                  onPressed: () {
                    game.overlays.remove('gameOver');
                    game.reset();
                  },
                ),
              ],
            ),
          ),
        ),
      },
      
    ),
    );
  }
}