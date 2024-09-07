// import 'package:flame/game.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waterdropdash/MainGameScreens/MainGame.dart';
// import 'package:waterdropdash/provider/GameState.dart';

// class RewardScreen extends StatefulWidget {
//   final DashGame game;


//   RewardScreen({required this.game});

//   @override
//   State<RewardScreen> createState() => _RewardScreenState();
// }

// class _RewardScreenState extends State<RewardScreen> {

//   @override
//   Widget build(BuildContext context) {
//     final gameState = Provider.of<GameState>(context);
//     return Center(
//       child: Container(
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'Well-done!',
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//             SizedBox(height: 20),
//             Image.asset('assets/images/water.png', height: 100),
//             SizedBox(height: 20),
//             Text(
//               'REWARD:',
//               style: TextStyle(fontSize: 18, color: Colors.orange),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   '100',
//                   style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blue),
//                 ),
//                 Image.asset('assets/images/dash.png', height: 40),
//               ],
//             ),
            
          
//             ElevatedButton(
//               child: Text('Continue'),
//               onPressed: () {
//                 widget.game.overlays.remove('rewardScreen');
//                 widget.game.overlays.add('levelComplete');
//                 widget.game.isGamePaused = false;
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }