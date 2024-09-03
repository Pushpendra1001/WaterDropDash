import 'package:flutter/material.dart';



class CityBuilderGame extends StatefulWidget {
  @override
  _CityBuilderGameState createState() => _CityBuilderGameState();
}

class _CityBuilderGameState extends State<CityBuilderGame> {
  int water = 300;
  int points = 300;
  List<Building> buildings = [
    Building(id: 1, name: 'Mountain', water: 10, maxWater: 30),
    Building(id: 2, name: 'Factory', water: 5, maxWater: 30),
    Building(id: 3, name: 'Stadium', water: 20, maxWater: 30),
    Building(id: 4, name: 'Houses', water: 10, maxWater: 30),
  ];

  void handleRestore(int id) {
    setState(() {
      var building = buildings.firstWhere((b) => b.id == id);
      if (!building.restored && water >= 10) {
        building.water = building.maxWater;
        building.restored = true;
        water -= 10;
        points += 50;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(color: Colors.green[100]),
          
          // Top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.white,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.opacity, color: Colors.blue),
                        SizedBox(width: 4),
                        Text('$water'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        SizedBox(width: 4),
                        Text('$points pts'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Building list
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            bottom: 0,
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: buildings.length,
              itemBuilder: (context, index) {
                final building = buildings[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(building.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                Icon(Icons.opacity, color: Colors.blue, size: 16),
                                SizedBox(width: 4),
                                Text('${building.water}/${building.maxWater}'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: building.restored || water < 10 ? null : () => handleRestore(building.id),
                          child: Text(building.restored ? 'Restored' : 'Restore'),
                          style: ElevatedButton.styleFrom(
                            
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Building {
  final int id;
  final String name;
  int water;
  final int maxWater;
  bool restored;

  Building({
    required this.id,
    required this.name,
    required this.water,
    required this.maxWater,
    this.restored = false,
  });
}