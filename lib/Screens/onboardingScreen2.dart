import 'package:flutter/material.dart';
import 'package:waterdropdash/Screens/RegisterScreen.dart';

class Onboardingscreen2 extends StatelessWidget {
  const Onboardingscreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(child: Image.asset("assets/Onboarding2.png"),),
            Container(
              width: MediaQuery.of(context).size.width/1.4,
              child: Text("Are you aware that unhealthy beverages cause tooth decay?", style: TextStyle(fontSize: 32 ,),),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen())),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff04344D),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Get Started", style: TextStyle(fontSize: 24 , color: Colors.white),),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}