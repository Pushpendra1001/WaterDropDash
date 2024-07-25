import 'package:flutter/material.dart';
import 'package:waterdropdash/MainGameScreens/GamePlayingScreen.dart';

class Levelgoalscreen extends StatelessWidget {
   Levelgoalscreen({super.key , required this.currentLevel , required this.waterBottleTarget});

  int currentLevel ;
  int waterBottleTarget ;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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

          SizedBox(height: MediaQuery.of(context).size.height*0.2,),
          Text("Goal" , style: TextStyle(fontSize: 64, ),),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(waterBottleTarget.toString() , style: TextStyle(fontSize: 64, ),),
                Image.asset("assets/images/water.png"),
              ],
            ),
          ),

          SizedBox(height: 20,),
Padding(
  padding: const EdgeInsets.all(48.0),
  child: Text("Tip : Drink water to stay hydrated and healthy" , style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold ),),
),
          InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Gameplayingscreen(currentLevel: currentLevel ,  waterBottleTarget:  waterBottleTarget,))),
            child: Container(
              
              child: Image.asset("assets/images/PlayBtn.png"),
            ),
          )
          
        ],
      ),
    );
  }
}