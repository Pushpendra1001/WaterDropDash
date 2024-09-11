import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterdropdash/GameMenuScreens/MainGameMenu.dart';
import 'package:waterdropdash/TipsScreens/TipScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    super.initState();
    _checkIfSeen();
  }

  Future<void> _checkIfSeen() async {
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool('seenWelcomeScreen') ?? false;

    if (seen) {
      _navigateToNextScreen();
    }
  }

  Future<void> _setSeenFlag() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenWelcomeScreen', true);
  }

  void _navigateToNextScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => TipScreen()), 
    );
  }

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
    "In the distant nation of HYDROLAND, an unprecedented drought plagued the land for a century, causing untold suffering and devastation",
    "So the council members of the land met, to deliberate on this issue, and find a solution for their nation",
    "The HydroLand council appointed Droppy as the hero to embark on a mission to Beverage Land",
    "The elders vested so much power on DROPPY, to enable him restore HydroLand to its former glory",
    "Embark on this journey with DROPPY, and gather as many water droplets to revive HYDROLAND!",
  ];

  final List<String?> _WelcomeUpperText = [
    null,
    null,
    """ Elder 1: "We need a hero to save HYDROLAND! 
Elder 2: Who can undertake this perilous quest?""",
    """
Droppy: 
"Why me though???
I am too weak to embark on such a quest
 for a huge nation like this"
""",
    """
Heroic Mascot Droppy: 
"Our Quest to BEVERAGE LAND begins!"
""",
    null,
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildPageIndicator(screenSize),
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
                    onTap: () => _handlePageTap(index, context),
                    child: _buildPageContent(index, screenSize),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator(Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_WelcomeSImages.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: _currentPage == index ? 12.0 : 8.0,
          height: screenSize.height * 0.02,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Colors.blue : Colors.grey,
          ),
        );
      }),
    );
  }

  Widget _buildPageContent(int index, Size screenSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (_WelcomeUpperText[index] != null)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              _WelcomeUpperText[index]!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        Image(
          image: AssetImage(_WelcomeSImages[index]),
          fit: BoxFit.contain,
          width: screenSize.width * 0.8,
          height: screenSize.height * 0.3,
        ),
        _buildMessageBox(index, screenSize),
      ],
    );
  }

  Widget _buildMessageBox(int index, Size screenSize) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/girlavtar.png",
          width: screenSize.width * 0.9,
          fit: BoxFit.contain,
        ),
        Positioned(
          
          child: Container(
            width: screenSize.width * 0.7,
            padding: const EdgeInsets.only(left: 50 , right: 24),
            child: Text(
              _WelcomeMMsg[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.0,
                color: Color.fromARGB(195, 0, 0, 0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handlePageTap(int index, BuildContext context) {
    if (index < _WelcomeSImages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TipScreen()),
      );
    }
  }
}
