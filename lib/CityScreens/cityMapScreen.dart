import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';
import 'package:waterdropdash/CityScreens/dashlandreward.dart';
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRestoreOptions();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(hours: 12), (timer) {
      _checkAndRestoreOptions();
    });
  }

  Future<void> _loadRestoreOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? optionsJson = prefs.getString('restoreOptions');
    if (optionsJson != null) {
      List<dynamic> decodedOptions = json.decode(optionsJson);
      setState(() {
        restoreOptions = decodedOptions.map((option) {
          return {
            ...Map<String, dynamic>.from(option),
            'position': Offset(option['position']['dx'], option['position']['dy']),
          };
        }).toList();
        _isLoading = false;
      });
    } else {
      _initializeRestoreOptions();
    }
  }

  void _initializeRestoreOptions() {
    restoreOptions = [
      {'name': 'Mountain', 'cost': 10, 'progress': 0, 'total': 30, 'position': Offset(150, 150), 'visible': true, 'lastHiddenTime': null},
      {'name': 'Forest', 'cost': 10, 'progress': 0, 'total': 60, 'position': Offset(200, 300), 'visible': true, 'lastHiddenTime': null},
      {'name': 'City', 'cost': 10, 'progress': 0, 'total': 20, 'position': Offset(100, 500), 'visible': true, 'lastHiddenTime': null},
      {'name': 'Badulands', 'cost': 10, 'progress': 0, 'total': 120, 'position': Offset(250, 700), 'visible': true, 'lastHiddenTime': null},
    ];
    _saveRestoreOptions();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveRestoreOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> optionsToSave = restoreOptions.map((option) {
      return {
        ...option,
        'position': {'dx': option['position'].dx, 'dy': option['position'].dy},
      };
    }).toList();
    String optionsJson = json.encode(optionsToSave);
    await prefs.setString('restoreOptions', optionsJson);
  }

  void _checkAndRestoreOptions() {
    bool updated = false;
    for (var option in restoreOptions) {
      if (!option['visible'] && option['lastHiddenTime'] != null) {
        DateTime lastHidden = DateTime.parse(option['lastHiddenTime']);
        if (DateTime.now().difference(lastHidden).inHours >= 12) {
          option['visible'] = true;
          option['progress'] = 0;
          option['position'] = _getRandomPosition();
          updated = true;
        }
      }
    }
    if (updated) {
      setState(() {});
      _saveRestoreOptions();
    }
  }

  Offset _getRandomPosition() {
    final random = Random();
    double x = random.nextDouble() * (MediaQuery.of(context).size.width - 100);
    double y = random.nextDouble() * (MediaQuery.of(context).size.height - 200) + 100;
    return Offset(x, y);
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
                    option['progress'] = (option['progress'] + option['cost']).clamp(0, option['total']);
                    if (option['progress'] == option['total']) {
                      option['visible'] = false;
                      option['lastHiddenTime'] = DateTime.now().toIso8601String();
                      _saveRestoreOptions();
                      Navigator.of(context).pop();
                      _showRewardScreen(context, option);
                    } else {
                      _saveRestoreOptions();
                      Navigator.of(context).pop();
                    }
                  });
                },
                child: Text('Restore'),
              ),
            ],
          );
        },
      );
    }
  }

  void _showRewardScreen(BuildContext context, Map<String, dynamic> option) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Dashlandreward(
          rewardAmount: Random().nextInt(100),
          badgeName: '${option['name']} Restorer',
        ),
      ),
    ).then((_) {
      // After returning from the reward screen, check if we need to reset the option
      if (option['progress'] == option['total']) {
        _startCooldown(option);
      }
    });
  }

 void _startCooldown(Map<String, dynamic> option) {
    setState(() {
      option['visible'] = false;
      option['lastHiddenTime'] = DateTime.now().toIso8601String();
    });
    _saveRestoreOptions();

    
    Timer(Duration(hours: 12), () {
      setState(() {
        option['progress'] = 0;
        option['visible'] = true;
        option['position'] = _getRandomPosition();
      });
      _saveRestoreOptions();
    });
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/dashland.png"),
                    ),
                  ),
                ),
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
                ...restoreOptions.where((option) => option['visible']).map((option) {
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