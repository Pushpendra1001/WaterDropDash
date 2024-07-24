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
  final List<String> _WelcomeMImages = [
    "assets/WelcomeSM1.png",
    "assets/WelcomeSM2.png",
    "assets/WelcomeSM3.png",
    "assets/WelcomeSM4.png",
    "assets/WelcomeSM5.png",
    "assets/WelcomeSM6.png",
    // Add more image paths here
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
            child: Icon(Icons.arrow_back_ios, color: Colors.white))),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(image: AssetImage(_WelcomeSImages[index]), fit: BoxFit.contain, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height*0.4),
                      Image(image: AssetImage(_WelcomeMImages[index]), alignment: Alignment.bottomCenter , fit: BoxFit.contain, width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.4,  ),
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


