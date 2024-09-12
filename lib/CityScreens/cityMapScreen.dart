import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterdropdash/CityScreens/dashlandreward.dart';
import 'package:waterdropdash/GameMenuScreens/ProgressScreen.dart';
import 'package:waterdropdash/MainGameScreens/MainGame.dart';
import 'package:waterdropdash/MainGameScreens/RewardScreen.dart';
import 'package:waterdropdash/provider/GameState.dart';


class CityMapScreen extends StatefulWidget {
  const CityMapScreen({Key? key}) : super(key: key);

  @override
  _CityMapScreenState createState() => _CityMapScreenState();
}

class _CityMapScreenState extends State<CityMapScreen> {
  List<Map<String, dynamic>> restoreOptions = [
    {'name': 'Mountain', 'cost': 10, 'progress': 0, 'total': 30, 'position': Offset(150, 150)},
    {'name': 'Forest', 'cost': 10, 'progress': 0, 'total': 60, 'position': Offset(200, 300)},
    {'name': 'City', 'cost': 10, 'progress': 0, 'total': 20, 'position': Offset(100, 500)},
    {'name': 'Badulands', 'cost': 10, 'progress': 0, 'total': 120, 'position': Offset(250, 700)},
  ];

  void _showRestoreDialog(BuildContext context, Map<String, dynamic> option) {
    final gameState = Provider.of<GameState>(context, listen: false);
    int currentScore = gameState.mainGameScore;

    if (currentScore < option['cost']) {
      _showInsufficientFundsDialog(context);
    } else if(option['progress'] == option['total']){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashlandreward(rewardAmount: 20,badgeName: '',),));
    } else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Restore ${option['name']}'),
            content: Text('Do you want to restore this area for ${option['cost']} points?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
gameState.setScore((currentScore - option['cost']).toInt());
                  setState(() {
                    option['progress'] = (option['progress'] + option['cost']).clamp(0, option['total']);
                    gameState.decreaseMainGameScore(option['progress']);
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Restore'),
              ),
            ],
          );
        },
      );
    }
  }

  void _showInsufficientFundsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Insufficient Points'),
          content: Text('You don\'t have enough points to restore this area.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showAlreadyFill(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Already Restored'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/dashland.png"),
              ),
            ),
          ),
          // New app bar
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset("assets/images/water.png"),
                      Text("Score", style: TextStyle(color: Colors.white)),
                      Text('${gameState.mainGameScore}', style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProgressScreen()),
                  ),
                  child: Image.asset("assets/TipS3.png", height: 50),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProgressScreen()));
                        },
                        child: Image.asset("assets/images/life.png")
                      ),
                      Text("Lives", style: TextStyle(color: Colors.white)),
                      Text('${gameState.lives}', style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Restore options
          ...restoreOptions.map((option) {
            return Positioned(
              left: option['position'].dx,
              top: option['position'].dy,
              child: GestureDetector(
                onTap: () => _showRestoreDialog(context, option),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('${option['progress']}/${option['total']}'),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Restore', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}