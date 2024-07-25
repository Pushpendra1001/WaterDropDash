import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Water Challenge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DailyChallengePage(),
    );
  }
}

class DailyChallengePage extends StatefulWidget {
  @override
  _DailyChallengePageState createState() => _DailyChallengePageState();
}

class _DailyChallengePageState extends State<DailyChallengePage> {
  double waterIntake = 0.0;
  double waterGoal = 1.5;

  void _drinkWater() {
    setState(() {
      waterIntake = (waterIntake + 0.25).clamp(0.0, waterGoal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
           
                ],
              ),
            ),
            Text(
              'Daily Challenge',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: WaterBodyWidget(percentage: waterIntake / waterGoal),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${waterIntake.toStringAsFixed(1)} L'),
                  Text('${waterGoal.toStringAsFixed(1)} L'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: LinearProgressIndicator(
                value: waterIntake / waterGoal,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                minHeight: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: ElevatedButton(
                onPressed: _drinkWater,
                child: Text('Drink Water'),
                style: ElevatedButton.styleFrom(
                  
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WaterBodyWidget extends StatelessWidget {
  final double percentage;

  const WaterBodyWidget({Key? key, required this.percentage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WaterBodyPainter(percentage: percentage),
      child: Container(),
    );
  }
}

class WaterBodyPainter extends CustomPainter {
  final double percentage;

  WaterBodyPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.1)
      ..lineTo(size.width * 0.8, size.height * 0.1)
      ..lineTo(size.width * 0.7, size.height * 0.9)
      ..lineTo(size.width * 0.3, size.height * 0.9)
      ..close();

    canvas.drawPath(path, paint);

    final waterPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final waterPath = Path()
      ..moveTo(size.width * 0.2, size.height * (1 - percentage))
      ..lineTo(size.width * 0.8, size.height * (1 - percentage))
      ..lineTo(size.width * 0.7, size.height * 0.9)
      ..lineTo(size.width * 0.3, size.height * 0.9)
      ..close();

    canvas.drawPath(waterPath, waterPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}