import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterdropdash/GameMenuScreens/ProgressScreen.dart';
import 'dart:async';

import 'package:waterdropdash/provider/GameState.dart';

class CityMapScreen extends StatefulWidget {
  const CityMapScreen({super.key});

  @override
  _CityMapScreenState createState() => _CityMapScreenState();
}

class _CityMapScreenState extends State<CityMapScreen> {
  List objects = [
    {'shop': 'Building', 'image': 'assets/icons/building.png', 'price': 100},
    {'shop': 'Factory', 'image': 'assets/icons/factory.png', 'price': 200},
    {'shop': 'House', 'image': 'assets/icons/home.png', 'price': 300},
    {'shop': 'Water Tank', 'image': 'assets/icons/watertank.png', 'price': 400},
    {'shop': 'Water Mine', 'image': 'assets/icons/watertank2.png', 'price': 500},
    {'shop': 'Water Tower', 'image': 'assets/icons/watertower.png', 'price': 600},
  ];

  List<Map<String, dynamic>> placedItems = [];
  Map<String, dynamic>? selectedItem;
  Offset itemPosition = Offset(100, 100);
  Timer? _timer;
  bool isMoving = false;

  void _showPurchaseDialog(BuildContext context, Map<String, dynamic> object) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Purchase ${object['shop']}'),
          content: Text('Do you want to buy this item for ${object['price']} coins?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  selectedItem = object;
                  itemPosition = Offset(100, 100); // Initial position
                  isMoving = true;
                });
                Navigator.of(context).pop(); // Close the dialog
                _startTimer();
              },
              child: Text('Buy'),
            ),
          ],
        );
      },
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: 10), () {
      setState(() {
        if (selectedItem != null) {
          placedItems.add({
            'item': selectedItem,
            'position': itemPosition,
          });
          selectedItem = null;
          isMoving = false;
        }
      });
    });
  }

  void _cancelMove() {
    setState(() {
      selectedItem = null;
      isMoving = false;
    });
    _timer?.cancel();
  }

  void _confirmMove() {
    setState(() {
      if (selectedItem != null) {
        placedItems.add({
          'item': selectedItem,
          'position': itemPosition,
        });
        selectedItem = null;
        isMoving = false;
      }
    });
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final itemSize = screenSize.width * 0.2; // Adjust the size based on screen width
    final itemBoxWidth = screenSize.width * 0.25; // Increase the width of the item box

    final gameState = Provider.of<GameState>(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/dashland.png"),
              ),
            ),
          ),
          // Score and Lives buttons at the top
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset("assets/images/water.png"),
                      Text("Score", style: TextStyle(color: Colors.white)),
                      Text('${gameState.highestScore}', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProgressScreen()),
                  ),
                  child: Image.asset("assets/TipS3.png", height: 50),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => BottleScannerGame()));
                        },
                        child: Image.asset("assets/images/life.png"),
                      ),
                      Text("Lives", style: TextStyle(color: Colors.white)),
                      Text('${gameState.lives}', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Placed items
          ...placedItems.map((placedItem) {
            return Positioned(
              left: placedItem['position'].dx,
              top: placedItem['position'].dy,
              child: Image.asset(
                placedItem['item']['image'],
                width: itemSize,
                height: itemSize,
              ),
            );
          }).toList(),
          // Draggable item
          if (selectedItem != null)
            Positioned(
              left: itemPosition.dx,
              top: itemPosition.dy,
              child: isMoving
                  ? Draggable(
                      feedback: _buildDraggableItem(itemSize),
                      childWhenDragging: Container(),
                      onDragEnd: (details) {
                        setState(() {
                          itemPosition = details.offset;
                        });
                      },
                      child: _buildDraggableItem(itemSize),
                    )
                  : _buildStaticItem(itemSize),
            ),
          // Horizontal scroller at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenSize.height * 0.2, // Adjust the height based on screen height
              child: ListView.builder(
                itemCount: objects.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _showPurchaseDialog(context, objects[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: itemSize,
                        width: itemBoxWidth,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  image: DecorationImage(
                                    filterQuality: FilterQuality.high,
                                    image: AssetImage(objects[index]['image']),
                                    fit: BoxFit.contain,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                objects[index]['shop'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenSize.width * 0.04, // Adjust font size based on screen width
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableItem(double itemSize) {
    return Stack(
      children: [
        Image.asset(
          selectedItem!['image'],
          width: itemSize,
          height: itemSize,
        ),
        if (isMoving)
          Positioned(
            top: 0,
            right: 0,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.check, color: Colors.green),
                  onPressed: _confirmMove,
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: _cancelMove,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildStaticItem(double itemSize) {
    return Image.asset(
      selectedItem!['image'],
      width: itemSize,
      height: itemSize,
    );
  }
}