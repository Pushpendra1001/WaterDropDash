import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameState extends ChangeNotifier {
  int _lives = 3;
  int _currentScore = 100;
  int _highestScore = 100;
  

  GameState() {
    _loadHighestScore();
  }

  int get lives => _lives;
  int get currentScore => _currentScore;
  int get highestScore => _highestScore;

  void setLives(int lives) {
    _lives = lives;
    notifyListeners();
  }

  void addLives(int amount) {
    _lives += amount;
    notifyListeners();
  }

  void decreaseLives() {
    if (_lives > 0) {
      _lives--;
      notifyListeners();
    }
  }

  void setCurrentScore(int score) {
    _currentScore = score;
    updateHighestScore();
    notifyListeners();
  }

  void addToCurrentScore(int amount) {
    _currentScore += amount;
    updateHighestScore();
    notifyListeners();
  }

  void updateHighestScore() {
    if (_currentScore > _highestScore) {
      _highestScore = _currentScore;
      _saveHighestScore();
    }
  }

  Future<void> _loadHighestScore() async {
    final prefs = await SharedPreferences.getInstance();
    _highestScore = prefs.getInt('highestScore') ?? 0;
    notifyListeners();
  }

  Future<void> _saveHighestScore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('highestScore', _highestScore);
  }

  void resetGame() {
    _lives = 3;
    _currentScore = 0;
    notifyListeners();
  }
}