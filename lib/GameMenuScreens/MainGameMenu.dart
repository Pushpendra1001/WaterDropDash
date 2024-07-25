import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waterdropdash/GameMenuScreens/DailyChallengePage.dart';
import 'package:waterdropdash/GameMenuScreens/GameLevelScreen.dart';
import 'package:waterdropdash/GameMenuScreens/GameSettingsScreen.dart';
import 'package:waterdropdash/MainGameScreens/GamePlayingScreen.dart';
import 'package:waterdropdash/TipsScreens/TipScreen.dart';

class GameMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                      Text("100" , style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),
                Image.asset(("assets/TipS3.png"), height: 50,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                        Image.asset("assets/images/life.png"),
                        Text("100" , style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ),
                ),
            
                
              ],
            ),
          ),

          Image.asset("assets/MainMenu.png"),
          SizedBox(height: 20,),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DailyChallengePage(),));
                },
                child: Center(child: Image.asset(("assets/TipS7.png"), height: 75,))),
            ],
          ),
          SizedBox(height: 40,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TipScreen( ),));
                },
                child: Center(child: Image.asset(("assets/TipS5.png"), height: 75,))),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GameLevelScreen( ),));
                },
                child: Center(child: Image.asset(("assets/images/PlayBtn.png"), height: 100,))),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen( ),));
                },
                child: Center(child: Image.asset(("assets/TipS6.png"), height: 75,))),
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
                child: Center(child: Image.asset(("assets/TipS8.png"), height: 75,))),
            ],
          )
        ],),
      )
    );
  }
}