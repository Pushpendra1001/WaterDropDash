import 'package:flutter/material.dart';
import 'package:waterdropdash/GameMenuScreens/GameLevelScreen.dart';
import 'package:waterdropdash/MainGameScreens/GamePlayingScreen.dart';

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
                      Image.asset("assets/images/bottle.png"),
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
              Center(child: Image.asset(("assets/TipS7.png"), height: 75,)),
            ],
          ),
          SizedBox(height: 40,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  print("hi");
                },
                child: Center(child: Image.asset(("assets/TipS5.png"), height: 75,))),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GameLevelScreen( ),));
                },
                child: Center(child: Image.asset(("assets/TipS9.png"), height: 100,))),
              Center(child: Image.asset(("assets/TipS6.png"), height: 75,)),
            ],
          ),
          SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Center(child: Image.asset(("assets/TipS8.png"), height: 75,)),
            ],
          )
        ],),
      )
    );
  }
}