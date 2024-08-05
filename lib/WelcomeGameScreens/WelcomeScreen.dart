import 'package:flutter/material.dart';
import 'package:waterdropdash/GameMenuScreens/MainGameMenu.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _WelcomeSImages = [
    "assets/WelcomeS1.png",
    "assets/WelcomeS2.png",
    "assets/WelcomeS3.png",
    "assets/WelcomeS4.png",
    "assets/WelcomeS5.png",
    "assets/WelcomeS6.png",
    // Add more image paths here
  ];
  final List<String> _WelcomeMMsg = [
    "Welcome to Drop Dash Join Droppy the friendly water droplet, on an exciting journey to stay hydrated and healthy by collecting water drops and completing fun challenges",
    "Levels and Challenges Navigate through various levels filled with unique obstacles and puzzles, using your quick thinking and agility to progress and unlock new stages",
    "Collect and Score Gather water drops to keep Droppy energized and boost your score. Look out for special bonus items to enhance your gameplay experience.",
    "Grow and Nurture Use collected points to grow a virtual tree, symbolizing Droppy's growth and health. Each completed level brings you closer to nurturing a thriving tree.",
    "Health Monitoring Keep Droppy's health bar filled by collecting water drops. If Droppy's health depletes, it's game over, so ensure a steady flow of hydration.",
    "Interactive Learning Learn about hydration and water conservation through engaging gameplay. Each level is designed to teach valuable lessons while keeping you entertained.",
    // Add more image paths here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_WelcomeSImages.length, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: _currentPage == index ? 12.0 : 8.0,
                
                height: MediaQuery.of(context).size.height * 0.1,
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
              itemCount: _WelcomeSImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (index < _WelcomeSImages.length - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                    else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => GameMenuScreen()),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(image: AssetImage(_WelcomeSImages[index]), fit: BoxFit.contain, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height*0.4),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(50), bottomRight: Radius.circular(50), bottomLeft: Radius.circular(50)),
                        color: Colors.pink.shade100,),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _WelcomeMMsg[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                    ],
                  )
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


