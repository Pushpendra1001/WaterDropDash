
// // GameState Provider
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class GameState extends ChangeNotifier {
//   int _score = 1000;
//   int _health = 100;
//   double _treeGrowth = 0.0;

//   int get score => _score;
//   int get health => _health;
//   double get treeGrowth => _treeGrowth;

//   void increaseScore(int value) {
//     _score += value;
//     notifyListeners();
//   }

//   void decreaseHealth(int value) {
//     _health -= value;
//     if (_health < 0) _health = 0;
//     notifyListeners();
//   }

//   void growTree(double value) {
//     _treeGrowth += value;
//     if (_treeGrowth > 1.0) _treeGrowth = 1.0;
//     notifyListeners();
//   }

//   Future<void> loadFromPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     _score = prefs.getInt('score') ?? 1000;
//     _health = prefs.getInt('health') ?? 100;
//     _treeGrowth = prefs.getDouble('treeGrowth') ?? 1.0;
//     notifyListeners();
//   }

//   Future<void> saveToPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setInt('score', _score);
//     prefs.setInt('health', _health);
//     prefs.setDouble('treeGrowth', _treeGrowth);
//   }



// }