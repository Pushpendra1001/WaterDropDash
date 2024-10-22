import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waterdropdash/provider/preferences_service.dart';

class GameState extends ChangeNotifier {
  int _lives = 3;
  int _currentScore = 100;
  int _mainGameScore = 0;
  int _currentlevel = 1;
  double _waterConsumed = 0.0; // Initial water consumed
  Set<String> _unlockedBadges = {};

  final PreferencesService _preferencesService = PreferencesService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  GameState() {
    _loadPreferences();
     _scheduleDailyReset();
  }

  int get lives => _lives;
  int get currentScore => _currentScore;
  int get mainGameScore => _mainGameScore;
  double get waterConsumed => _waterConsumed;
  int get currentlevel => _currentlevel;
  Set<String> get unlockedBadges => _unlockedBadges;

  void _loadPreferences() async {
    _lives = await _preferencesService.getLives();
    _currentScore = await _preferencesService.getScore();
    _mainGameScore = await _preferencesService.getMainGameScore();
    _currentlevel = await _preferencesService.getCurrentLevel();
    _unlockedBadges = await _preferencesService.getUnlockedBadges();
     _waterConsumed = await _preferencesService.getWaterConsumed();
    notifyListeners();
  }

  void resetWaterConsumed() {
  _waterConsumed = 0.0;
  _preferencesService.saveWaterConsumed(_waterConsumed);
  notifyListeners();
}


void _scheduleDailyReset() {
  final now = DateTime.now();
  final nextMidnight = DateTime(now.year, now.month, now.day + 1);
  final durationUntilMidnight = nextMidnight.difference(now);

  Timer(durationUntilMidnight, () {
    resetWaterConsumed();
    _scheduleDailyReset(); // Reschedule the reset for the next day
  });
}


  void setMainGameScore(int score) {
    _mainGameScore = score;
    _preferencesService.saveMainGameScore(score);
    _updateUserTotalScoreOnFirebase(score);
    notifyListeners();
  }

  void increaseWaterConsumed(double amount) {
  _waterConsumed += amount;
  if (_waterConsumed > 1.5) {
    _waterConsumed = 1.5; // Cap the water consumed at 1.5L
  }
  _preferencesService.saveWaterConsumed(_waterConsumed);
  notifyListeners();
}



  void increaseMainGameScore(int amount) {
    _mainGameScore += amount;
    _preferencesService.saveMainGameScore(_mainGameScore);
    _updateUserTotalScoreOnFirebase(_mainGameScore);
    notifyListeners();
  }

  void decreaseMainGameScore(int amount) {
    if (_mainGameScore >= amount) {
      _mainGameScore -= amount;
      _preferencesService.saveMainGameScore(_mainGameScore);
      // _updateUserTotalScoreOnFirebase(_mainGameScore);
      notifyListeners();
    }
  }

  void setCurrentLevel(int level) {
    _currentlevel = level;
    _preferencesService.saveCurrentLevel(level);
    notifyListeners();
  }

  void updatedCurrentLevel() {
    _currentlevel++;
    _preferencesService.saveCurrentLevel(_currentlevel);
    notifyListeners();
  }

  void setLives(int lives) {
    _lives = lives;
    _preferencesService.saveLives(lives);
    notifyListeners();
  }

  void addLives(int amount) {
    _lives += amount;
    _preferencesService.saveLives(_lives);
    notifyListeners();
  }

  void decreaseLives() {
    if (_lives > 0) {
      _lives--;
      _preferencesService.saveLives(_lives);
      notifyListeners();
    }
  }

  void increaseScore(int amount) {
    _currentScore += amount;
    _preferencesService.saveScore(_currentScore);
    notifyListeners();
  }

  void setScore(int score) {
    _currentScore = score;
    _preferencesService.saveScore(score);
    notifyListeners();
  }

  void unlockBadge(String badgeName) {
    _unlockedBadges.add(badgeName);
    _preferencesService.saveUnlockedBadges(_unlockedBadges);
    notifyListeners();
  }

  bool isBadgeUnlocked(String badgeName) {
    return _unlockedBadges.contains(badgeName);
  }

  void resetGame() {
    _lives = 3;
    _currentScore = 0;
    _mainGameScore = 0;
    _currentlevel = 1;
    _unlockedBadges.clear();
    _preferencesService.saveLives(_lives);
    _preferencesService.saveScore(_currentScore);
    _preferencesService.saveMainGameScore(_mainGameScore);
    _preferencesService.saveCurrentLevel(_currentlevel);
    _preferencesService.saveUnlockedBadges(_unlockedBadges);
    notifyListeners();
  }

 Future<void> _updateUserTotalScoreOnFirebase(int score) async {
  try {
    // Get the current authenticated user
    User? currentUser = FirebaseAuth.instance.currentUser;

    // Ensure the user is not null
    if (currentUser != null) {
      String userId = currentUser.uid;

      // Update the user's score in Firestore
      await _firestore.collection('users').doc(userId).update({
        'UserTotalScore': score + _mainGameScore,
      });
    } else {
      print('Error: currentUser is null');
    }
  } catch (e) {
    print('Error updating score on Firebase: $e');
  }
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