import 'package:flutter/material.dart';
import 'package:waterdropdash/Screens/RegisterScreen.dart';


class Onboardingscreen2 extends StatelessWidget {
  const Onboardingscreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height/2,
            child: Center(
              child: Image.asset("assets/Onboarding2.png"),),
          ),
          Container(
            width: MediaQuery.of(context).size.width/1.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Are you aware that unhealthy beverages cause tooth decay?", style: TextStyle(fontSize: 16  ,),),
                    SizedBox(height: 40,),
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
            
        
      
          
        ],
      ),
    );
  }
}