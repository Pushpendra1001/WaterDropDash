import 'package:flutter/material.dart';

class Commingsoon extends StatelessWidget {
  const Commingsoon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("Comming Soon" , style: TextStyle(fontSize: 24),))
          ],
        ),
      ),
    );
  }
}