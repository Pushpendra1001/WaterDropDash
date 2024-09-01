import 'package:flutter/material.dart';
import 'package:waterdropdash/GameMenuScreens/MainGameMenu.dart';
import 'package:waterdropdash/TipsScreens/TipScreen.dart';

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
    
  ];
  final List<String> _WelcomeMMsg = [
    "Before you begin your journey, Let me tell you all about HYDROLAND and DROPPY your partner in this QUEST!",
    "Levels and Challenges Navigate through various levels filled with unique obstacles and puzzles, using your quick thinking and agility to progress and unlock new stages",
    "Collect and Score Gather water drops to keep Droppy energized and boost your score. Look out for special bonus items to enhance your gameplay experience.",
    "Grow and Nurture Use collected points to grow a virtual tree, symbolizing Droppy's growth and health. Each completed level brings you closer to nurturing a thriving tree.",
    "Health Monitoring Keep Droppy's health bar filled by collecting water drops. If Droppy's health depletes, it's game over, so ensure a steady flow of hydration.",
    "Interactive Learning Learn about hydration and water conservation through engaging gameplay. Each level is designed to teach valuable lessons while keeping you entertained.",
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
                        MaterialPageRoute(builder: (context) => TipScreen()),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(image: AssetImage(_WelcomeSImages[index]), fit: BoxFit.contain, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height*0.4),
                    SizedBox(height: 20,),
                  Stack(
                    children: [
                      Image.asset("assets/girlavtar.png"),
                         Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 35 , ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: MediaQuery.of(context).size.width/2,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                _WelcomeMMsg[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  
                    ],
                  ),
                  
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


