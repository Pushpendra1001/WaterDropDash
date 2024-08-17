// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:waterdropdash/provider/SaveScores.dart';

// class TreeScreen extends StatefulWidget {
//   @override
//   State<TreeScreen> createState() => _TreeScreenState();
// }

// class _TreeScreenState extends State<TreeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final gameState = Provider.of<GameState>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Magical Growing Tree'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: Consumer<GameState>(
//         builder: (context, gameState, child) {
//           return Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Colors.lightBlue[200]!, Colors.green[200]!],
//               ),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: GrowingTreeWidget(growthFactor: gameState.treeGrowth),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                Text(
//               'Tree Growth: ${(gameState.treeGrowth)}%',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Score: ${gameState.score}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 if (gameState.score >= 10) {
//                   gameState.increaseScore(-10);
//                   // gameState.growTree(5.0);
//                   gameState.saveToPrefs();
//                 }
//               },
//               child: Text('Grow Tree'),
//             ), ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
// class GrowingTreeWidget extends StatefulWidget {
//   final double growthFactor;

//   const GrowingTreeWidget({Key? key, required this.growthFactor}) : super(key: key);

//   @override
//   _GrowingTreeWidgetState createState() => _GrowingTreeWidgetState();
// }

// class _GrowingTreeWidgetState extends State<GrowingTreeWidget> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: Duration(milliseconds: 500),
//       vsync: this,
//     );

//     _animation = Tween<double>(begin: 0, end: widget.growthFactor).animate(_controller)
//       ..addListener(() {
//         setState(() {});
//       });

//     _controller.forward();
//   }

//   @override
//   void didUpdateWidget(GrowingTreeWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.growthFactor != widget.growthFactor) {
//       _animation = Tween<double>(begin: _animation.value, end: widget.growthFactor).animate(_controller);
//       _controller
//         ..reset()
//         ..forward();
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: TreePainter(growthFactor: _animation.value),
//       child: Container(),
//     );
//   }
// }

// class TreePainter extends CustomPainter {
//   final double growthFactor;

//   TreePainter({required this.growthFactor});

//  @override
// void paint(Canvas canvas, Size size) {
//   final paint = Paint()
//     ..style = PaintingStyle.fill;

  
//   final maxTrunkHeight = size.height * 0.6;
//   final maxTrunkWidth = size.width * 0.1;
//   final maxLeafRadius = size.width * 0.2;

//   final currentTrunkHeight = maxTrunkHeight * growthFactor;
//   final currentTrunkWidth = maxTrunkWidth * growthFactor;
//   final currentLeafRadius = maxLeafRadius * growthFactor;

  
//   paint.color = Colors.brown;
//   final trunkRect = Rect.fromLTWH(
//     size.width / 2 - currentTrunkWidth / 2,
//     size.height - currentTrunkHeight,
//     currentTrunkWidth,
//     currentTrunkHeight
//   );
//   canvas.drawRect(trunkRect, paint);

  
//   paint.color = Colors.green;
//   final leafCenter = Offset(size.width / 2, size.height - currentTrunkHeight);
//   canvas.drawCircle(leafCenter, currentLeafRadius, paint);
// }
//   @override
//   bool shouldRepaint(TreePainter oldDelegate) {
//     return oldDelegate.growthFactor != growthFactor;
//   }
// }