import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterdropdash/CityScreens/DashLandScreen2.dart';
import 'package:waterdropdash/GameMenuScreens/DailyChallengePage.dart';
import 'package:waterdropdash/GameMenuScreens/GameLevelScreen.dart';
import 'package:waterdropdash/GameMenuScreens/GameSettingsScreen.dart';
import 'package:waterdropdash/GameMenuScreens/ProgressScreen.dart';
import 'package:waterdropdash/GameMenuScreens/ScannerScreen.dart';
import 'package:waterdropdash/CityScreens/DashLandScreen.dart';
import 'package:waterdropdash/MainGameScreens/GamePlayingScreen.dart';
import 'package:waterdropdash/MainGameScreens/TreeScreen.dart';
import 'package:waterdropdash/Screens/LeaderboardScreen.dart';
import 'package:waterdropdash/TipsScreens/TipScreen.dart';
import 'package:waterdropdash/provider/GameState.dart';
import 'package:waterdropdash/provider/SaveScores.dart';

class GameMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final gameState = Provider.of<GameState>(context);
    

     _setUserReachedMainGameMenu();
    return Scaffold(
   backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
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
                        Text('${gameState.highestScore}', style: TextStyle(color: Colors.white),)
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
              //  Navigator.push(context, MaterialPageRoute(builder: (context) => BottleScannerGame(),));
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
          // Align(child: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 30),
          //   child: InkWell(
          //     onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => TipScreen(),)),
          //     child: Text("Tips" , style: TextStyle(fontSize: 16),)),
          // ),alignment: Alignment.bottomRight,),   
            InkWell(
              onTap: () => Navigator.push(context,    MaterialPageRoute(
              builder: (context) =>  WaterDropCity(),
            ),),
              child: Image.asset("assets/MainMenu.png")),
            SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LeaderboardScreen(),));
                  },
                  child: Column(children
                  
                  : [ Center(child: Image.asset(("assets/TipS7.png"), height: 75,)), Text("Leaderboard"),]),
            )],
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DailyChallengeScreen( ),));
                  },
                  child: Column(
                    children: [
                      Center(child: Image.asset(("assets/TipS5.png"), height: 75,)),
                      Text("Challenge")
                    ],
                  )),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GameLevelScreen( ),));
                  },
                  child: Column(
                    children: [
                      Center(child: Image.asset(("assets/images/PlayBtn.png"), height: 100,)),
                      Text("Play")
                    ],
                  )),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen( ),));
                  },
                  child: Column(
                    children: [
                      Center(child: Image.asset(("assets/TipS6.png"), height: 75,)),
                      Text("Settings")
                    ],
                  )),
              ],
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 InkWell(
                  onTap: (){
                      showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
          title: Text("Exit"),
          content: Text("Do you want to exit?"),
          actions: [
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                SystemNavigator.pop(); // Exit the app
              },
            ),
          ],
                );
              },
            );
                  },
                  child: Column(
                    children: [
                      Center(child: Image.asset(("assets/TipS8.png"), height: 75,)),
                      Text("Exit")
                    ],
                  )),
              ],
            ),
          
                 
          ],),
        ),
      )
    );
  }

   Future<void> _setUserReachedMainGameMenu() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('userReachedMainGameMenu', true);
  }
}