import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';


class GameState extends ChangeNotifier {
  int _lives = 3;
  int _currentScore = 100;
  int _mainGameScore = 0;
  int _currentlevel = 1;
   Set<String> _unlockedBadges = {}; 
  

  GameState() {
    // _loadHighestScore();
  }

  int get lives => _lives;
  // int get currentScore => _currentScore;
  int get mainGameScore => _mainGameScore;
  int get currentlevel => _currentlevel;
  Set<String> get unlockedBadges => _unlockedBadges;


  void setMainGameScore(int score) {
    _mainGameScore = score;
    notifyListeners();
  }

  void increaseMainGameScore(int amount) {
    _mainGameScore += amount;
    notifyListeners();
  }

    void decreaseMainGameScore(int amount) {
    if (_mainGameScore >= amount) {
      _mainGameScore -= amount;
      notifyListeners();
    }
  }

  void setCurrentLevel(int level) {
    _currentlevel = level;
    notifyListeners();
  }

  void updatedCurrentLevel() {
    _currentlevel++;
    notifyListeners();
  }

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

  void increaseScore(int amount) {
    _currentScore += amount;
    notifyListeners();
  }

  void setScore(int score) {
    _currentScore = score;
    notifyListeners();
  }

  void unlockBadge(String badgeName) {
    _unlockedBadges.add(badgeName);
    notifyListeners();
  }

  bool isBadgeUnlocked(String badgeName) {
    return _unlockedBadges.contains(badgeName);
  }

  

  void resetGame() {
    _lives = 3;
    _currentScore = 0;
    notifyListeners();
  }
}


class AvatarProvider extends ChangeNotifier {
  String _selectedAvatar = 'dash2.png';  // Default avatar

  AvatarProvider() {
    loadAvatar();
  }

  String get selectedAvatar => _selectedAvatar;

  void setAvatar(String avatarFileName) {
    if (_selectedAvatar != avatarFileName) {
      _selectedAvatar = avatarFileName;
      saveAvatar();
      notifyListeners();
    }
  }

  Future<void> saveAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('avatar', _selectedAvatar);
  }

  Future<void> loadAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedAvatar = prefs.getString('avatar') ?? 'dash2.png';
    notifyListeners();
  }
}