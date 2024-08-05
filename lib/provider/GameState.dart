import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameState extends ChangeNotifier {
  double _treeGrowth = 10.0; 
  int _score = 0;

  double get treeGrowth => _treeGrowth;
  int get score => _score;

  void increaseScore(int amount) {
    _score += amount;
    notifyListeners();
  }

  void growTree(double amount) {
    _treeGrowth += amount;
    notifyListeners();
  }

  Future<void> saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('treeGrowth', _treeGrowth);
    await prefs.setInt('score', _score);
  }

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _treeGrowth = prefs.getDouble('treeGrowth') ?? 10.0;
    _score = prefs.getInt('score') ?? 0;
    notifyListeners();
  }
}
