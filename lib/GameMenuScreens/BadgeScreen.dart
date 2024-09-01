import 'package:flutter/material.dart';

class BadgesScreen extends StatelessWidget {
  final List<String> badges = [
    'cb1.png', 'cb2', 'cb3',
     'cb4', 'cb5', 'cb6', 
     'cb7', 'cb8', 'cb9', 
     'cb10','cb11', 'cb12', 
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF001C38),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Text(
              'Badges',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 25,),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: badges.length,
                itemBuilder: (context, index) {
                  return Image.asset('assets/badges/cb${index+1}.png');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}