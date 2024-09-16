import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future<void> saveMainGameScore(int score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('mainGameScore', score);
  }

  Future<int> getMainGameScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('mainGameScore') ?? 0;
  }

  Future<void> saveScore(int score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentScore', score);
  }

  Future<int> getScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('currentScore') ?? 0;
  }

  Future<void> saveLives(int lives) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lives', lives);
  }

  Future<int> getLives() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('lives') ?? 3;
  }

  Future<void> saveCurrentLevel(int level) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentLevel', level);
  }

  Future<int> getCurrentLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('currentLevel') ?? 1;
  }

  Future<void> saveUnlockedBadges(Set<String> badges) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('unlockedBadges', badges.toList());
  }

  Future<Set<String>> getUnlockedBadges() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('unlockedBadges')?.toSet() ?? {};
  }

  Future<void> saveUserId(String userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', userId);
}

Future<String> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId') ?? '';
}

}