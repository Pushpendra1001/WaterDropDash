import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterdropdash/GameMenuScreens/MainGameMenu.dart';
import 'package:waterdropdash/MainGameScreens/MainGame.dart';
import 'package:waterdropdash/Screens/RegisterScreen.dart';
import 'package:waterdropdash/Screens/SplashScreen.dart';
import 'package:waterdropdash/Screens/onboardingScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AudioPlayer _audioPlayer;
  bool _userReachedMainGameMenu = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playBackgroundMusic();
    _checkIfUserReachedMainGameMenu();
  }

  void _playBackgroundMusic() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource('m2.mp3'));
  }

  Future<void> _checkIfUserReachedMainGameMenu() async {
    final prefs = await SharedPreferences.getInstance();
    bool reachedMainGameMenu = prefs.getBool('userReachedMainGameMenu') ?? false;
    setState(() {
      _userReachedMainGameMenu = reachedMainGameMenu;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: GoogleFonts.pottaOne().fontFamily,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: _userReachedMainGameMenu ? GameMenuScreen() : SplashScreen(),
      );
    }
  }
}
