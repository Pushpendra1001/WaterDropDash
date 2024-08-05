import 'package:flutter/material.dart';
import 'package:waterdropdash/GameMenuScreens/MainGameMenu.dart';

class TipScreen extends StatefulWidget {
  const TipScreen({super.key});

  @override
  TipScreenState createState() => TipScreenState();
}

class TipScreenState extends State<TipScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _tipImages = [
    "assets/TipS1.png",
    "assets/TipS2.png",
    "assets/TipS3.png",
    "assets/TipS4.png",
    "assets/TipS5.png",
    "assets/TipS6.png",
    "assets/TipS7.png",
    "assets/TipS8.png",
    "assets/images/PlayBtn.png",
  ];

  final List<List<String>> _tipTexts = [
    ["Quick Start: Use the Quick Start button to jump directly into the action without navigating through multiple menus."],
    ["Explore Options: Take a moment to explore the various menu options to get the most out of the game features and settings."],
    ["Check Your Rank: Regularly check the leaderboard to see how you rank against other players and strive to improve your position."],
    ["Collect Points: Use the points you collect during gameplay to grow your virtual tree, making it flourish and thrive."],
    ["Customize Experience: Use the settings menu to adjust game sound, graphics quality, and other preferences to tailor the game to your liking."],
    ["Stay Hydrated: Keep an eye on Droppy's health bar to ensure he stays hydrated and energetic throughout the game."],
    ["Customize Experience: Use the settings menu to adjust game sound, graphics quality, and other preferences to tailor the game to your liking."],
    ["Collect Power-ups: Look for and collect power-ups to give Droppy temporary boosts and make challenging levels easier to complete."],
    ["Always make sure your game progress is saved before exiting to avoid losing any achievements or collected points."],
    ["Use Hints: Don't hesitate to use hints if you get stuck on a puzzle or challenge; they can provide valuable guidance."],
    ["Ready to play?"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_tipImages.length, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: _currentPage == index ? 12.0 : 8.0,
                height: MediaQuery.of(context).size.height * 0.02,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index ? Colors.blue : Colors.grey,
                ),
              );
            }),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: _tipImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (index < _tipImages.length - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => GameMenuScreen()),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Image (30% width)
                        Expanded(
                          flex: 10,
                          child: Image(
                            image: AssetImage(_tipImages[index]),
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(width: 16),
                        // Text content (70% width)
                        SizedBox(height: MediaQuery.of(context).size.height/4,),
                        Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tip ${index + 1}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(height: 16),
                              ..._tipTexts[index].map((text) => Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("• ", style: TextStyle(fontSize: 18, color: Colors.blue)),
                                    Expanded(
                                      child: Text(
                                        text,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}