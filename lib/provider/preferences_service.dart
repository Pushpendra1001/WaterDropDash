import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future<void> saveLives(int lives) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lives', lives);
  }

  Future<int> getLives() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('lives') ?? 3; // Default to 3 lives if not set
  }

  Future<void> saveScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('score', score);
  }

  Future<int> getScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('score') ?? 0; // Default to 0 score if not set
  }

  Future<void> saveMainGameScore(int mainGameScore) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('mainGameScore', mainGameScore);
  }

  Future<int> getMainGameScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('mainGameScore') ?? 0; // Default to 0 main game score if not set
  }

  Future<void> saveCurrentLevel(int currentLevel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentLevel', currentLevel);
  }

  Future<int> getCurrentLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('currentLevel') ?? 1; // Default to level 1 if not set
  }

  Future<void> saveUnlockedBadges(Set<String> unlockedBadges) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('unlockedBadges', unlockedBadges.toList());
  }

  Future<Set<String>> getUnlockedBadges() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('unlockedBadges')?.toSet() ?? {};
  }
}