import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    ["Tip : As your GUIDE, let me help you familiarize with this terrain READY???"],
    ["Tip : This is your portal, you can always return to HYDROLAND with just a TAP."],
    ["TIP : This takes you to your progress dashboard."],
    ["Tip : Let me introduce you to your friendly MENU companions"],
    ["Tip : Complete Daily Challenges to win prizes that can help you in this quest with just a TAP."],
    ["Tip : Customize the sound and music, and not just that, DROPPY”S appearance too!"],
    ["Tip: See how you rank in comparison to other heroes like you globally!"],
    ["Tip: You can exit DropDash with this, but I am sure you would not like to do that just yet!"],
    ["Tip: Can’t wait to get started right?That is what this button is for.HIT IT!"],
     ];

 @override
  void initState() {
    super.initState();
    _checkIfSeen();
  }

  Future<void> _checkIfSeen() async {
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool('seenTipScreen') ?? false;

    if (seen) {
      print(seen);
      _navigateToNextScreen();
    }
  }

  Future<void> _setSeenFlag() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenTipScreen', true);
  }

  void _navigateToNextScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => GameMenuScreen()),
    );
  }


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
    child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(image: AssetImage(_tipImages[index]), fit: BoxFit.contain, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height*0.4),
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
                              padding:  EdgeInsets.all(16.0),
                              child: Text(
                                _tipTexts[index].first,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.0,
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