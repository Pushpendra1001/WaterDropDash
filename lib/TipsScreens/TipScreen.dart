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

  final List<String> _TipSImages = [
    "assets/TipS1.png",
    "assets/TipS2.png",
    "assets/TipS3.png",
    "assets/TipS4.png",
    "assets/TipS5.png",
    "assets/TipS6.png",
    "assets/TipS7.png",
    "assets/TipS8.png",
    "assets/TipS9.png",
    // Add more image paths here
  ];
  final List<String> _TipMImages = [
    "assets/TipM1.png",
    "assets/TipM2.png",
    "assets/TipM3.png",
    "assets/TipM4.png",
    "assets/TipM5.png",
    "assets/TipM6.png",
    "assets/TipM7.png",
    "assets/TipM8.png",
    "assets/TipM9.png",
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
            children: List.generate(_TipSImages.length, (index) {
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
              itemCount: _TipSImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (index < _TipSImages.length - 1) {
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
                      Image(image: AssetImage(_TipSImages[index]), fit: BoxFit.contain, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height*0.4),
                      Image(image: AssetImage(_TipMImages[index]), alignment: Alignment.bottomCenter , fit: BoxFit.contain, width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.4,  ),
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


