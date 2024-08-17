import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterdropdash/GameMenuScreens/ScannerScreen.dart';
import 'package:waterdropdash/MainGameScreens/GamePlayingScreen.dart';
import 'package:waterdropdash/provider/GameState.dart';
import 'package:waterdropdash/provider/SaveScores.dart';

class Levelgoalscreen extends StatelessWidget {
   Levelgoalscreen({super.key , required this.currentLevel , required this.waterBottleTarget});

  final int currentLevel;
  final int waterBottleTarget;

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset("assets/images/water.png"),
                        Text('${gameState.highestScore}', style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ),
                  Image.asset(("assets/TipS3.png"), height: 50,),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BottleScannerGame())),
                            child: Image.asset("assets/images/life.png")),
                          Text('${gameState.lives}' , style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Text("Level ${currentLevel+1} Goal", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(waterBottleTarget.toString(), style: TextStyle(fontSize: 64)),
                  Image.asset("assets/images/water.png"),
                ],
              ),
            ),

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Game Instructions:", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("1. Collect healthy drinks:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Image.asset("assets/images/water1.png", height: 30),
                      Text(" Water: +2 points", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset("assets/images/lemon-tea.png", height: 30),
                      Text(" Lemon Tea: +1 point", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("2. Dodge obstacles:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Image.asset("assets/images/wine.png", height: 30),
                      Image.asset("assets/images/soda.png", height: 30),
                      Text(" Wine, Soda, etc.", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Text("   Hitting an obstacle deducts 1 life!", style: TextStyle(fontSize: 16, color: Colors.red)),
                  SizedBox(height: 10),
                  Text("3. Reach the water bottle target to complete the level!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Tip: Stay hydrated and make healthy drink choices!", style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
            ),

            SizedBox(height: 20),
              InkWell(
              onTap: () {
                if (gameState.lives > 0) {
                  gameState.decreaseLives();
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => Gameplayingscreen(
                        currentLevel: currentLevel, 
                        waterBottleTarget: waterBottleTarget
                      )
                    )
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('No Lives Left'),
                        content: Text('You don\'t have any lives left. Please scan bottles to get more lives.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Container(
                child: Image.asset("assets/images/PlayBtn.png"),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}