// import 'package:flutter/material.dart';
// import 'package:waterdropdash/Screens/onboardingScreen2.dart';

// class Onboardingscreen extends StatelessWidget {
//   const Onboardingscreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height/2,
//             child: Center(
//               child: Image.asset("assets/Onboarding.png"),),
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width/1.4,
//             child: Column(
//               children: [
//                 Text("It is recommended that you take 1 litre of water a day", style: TextStyle(fontSize: 16 ,),),
                    
//                     SizedBox(height: 40,),
//                     InkWell(
//               onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Onboardingscreen2())),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: Color(0xff04344D),
//                 ),
                
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Text("Get Started", style: TextStyle(fontSize: 24 , color: Colors.white),),
//                 ),
//               ),
//             )
//               ],
//             ),
//             ),
            
        
      
          
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:waterdropdash/Screens/RegisterScreen.dart';

class CombinedOnboardingScreen extends StatefulWidget {
  const CombinedOnboardingScreen({Key? key}) : super(key: key);

  @override
  _CombinedOnboardingScreenState createState() => _CombinedOnboardingScreenState();
}

class _CombinedOnboardingScreenState extends State<CombinedOnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<String> _images = [
    "assets/Onboarding.png",
    "assets/Onboarding2.png",
  ];

  final List<String> _texts = [
    "It is recommended that you take 1 litre of water a day",
    "Are you aware that unhealthy beverages cause tooth decay?",
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
       
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      _pageController.animateToPage(
                        1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: _buildPage(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2,
          child: Center(
            child: Image.asset(_images[index]),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Column(
            children: [
              Text(
                _texts[index],
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
                 Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_images.length, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: _currentPage == index ? 12.0 : 8.0,
                height: MediaQuery.of(context).size.height * 0.02,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index ? Colors.orange : Colors.grey,
                ),
              );
            }),
          ),
              if (index == 1) ...[
                SizedBox(height: 40),
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen())),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff04344D),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Get Started",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}