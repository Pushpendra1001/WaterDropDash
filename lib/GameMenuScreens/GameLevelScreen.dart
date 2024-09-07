import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterdropdash/GameMenuScreens/ProgressScreen.dart';
import 'package:waterdropdash/GameMenuScreens/ScannerScreen.dart';
import 'package:waterdropdash/MainGameScreens/GamePlayingScreen.dart';
import 'package:waterdropdash/MainGameScreens/LevelGoalScreen.dart';
import 'package:waterdropdash/provider/GameState.dart';
import 'package:waterdropdash/provider/SaveScores.dart';

class GameLevelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final gameState = Provider.of<GameState>(context);

    return Scaffold(
    
      body: Container(
        padding: EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/skbg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
           Padding(
              padding:  EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/3,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset("assets/images/water.png"),
                        Text("Score" , style: TextStyle(color: Colors.white),),
                        Text('${gameState.mainGameScore}', style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProgressScreen(),)),
                    child: Image.asset(("assets/TipS3.png"), height: 50,)),
                  Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width/ 3,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                             onTap : (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => BottleScannerGame(),));
            },
                            child: Image.asset("assets/images/life.png")),
                            Text("Lives" , style: TextStyle(color: Colors.white),),
                          Text('${gameState.lives}' , style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                  ),
              
                  
                ],
              ),
            ),
         Text(
              "Select Level",
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 15,
                itemBuilder: (context, index) {
                  bool isLocked = index >= gameState.currentlevel;
                  return InkWell(
                    onTap: () {
                      if (isLocked) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Level Locked'),
                            content: Text('Please complete previous levels to unlock this level.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      } else {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => Levelgoalscreen(currentLevel: index, waterBottleTarget: index*10 +10,),));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isLocked ? Colors.grey : Colors.blue.shade600,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          isLocked ? 'Locked' : '${index + 1}',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
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