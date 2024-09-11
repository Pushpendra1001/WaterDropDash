import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterdropdash/GameMenuScreens/ProgressScreen.dart';
import 'package:waterdropdash/provider/GameState.dart';

class CityMapScreen extends StatefulWidget {
  const CityMapScreen({Key? key}) : super(key: key);

  @override
  _CityMapScreenState createState() => _CityMapScreenState();
}

class _CityMapScreenState extends State<CityMapScreen> {
  List<Map<String, dynamic>> restoreOptions = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    // Timer that triggers every 8 hours (28800000 milliseconds)
    _timer = Timer.periodic(Duration(milliseconds: 28800000), (timer) {
      _addRandomRestoreOption();
    });
  }

  void _addRandomRestoreOption() {
    if (restoreOptions.length < 5) { // Limit to 5 options at a time
      final random = Random();
      final newOption = {
        'name': 'Water Restore ${restoreOptions.length + 1}',
        'cost': random.nextInt(100) + 50, // Random cost between 50 and 149
        'progress': 0,
        'total': random.nextInt(20) + 10, // Random total between 10 and 29
        'position': Offset(
          random.nextDouble() * (MediaQuery.of(context).size.width - 100),
          random.nextDouble() * (MediaQuery.of(context).size.height - 200) + 100,
        ),
      };
      setState(() {
        restoreOptions.add(newOption);
      });
    }
  }

  void _showRestoreDialog(BuildContext context, Map<String, dynamic> option) {
    final gameState = Provider.of<GameState>(context, listen: false);
    int currentScore = gameState.mainGameScore;

    if (currentScore < option['cost']) {
      _showInsufficientFundsDialog(context);
    } else {
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
                  gameState.decreaseMainGameScore(option['cost']);
                  setState(() {
                    option['progress']++;
                    if (option['progress'] >= option['total']) {
                      restoreOptions.remove(option);
                    }
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
          // App bar
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
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Restore Water', style: TextStyle(color: Colors.white)),
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