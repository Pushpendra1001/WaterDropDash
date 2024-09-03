import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Drop City',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WaterDropCity(),
    );
  }
}

class WaterDropCity extends StatefulWidget {
  @override
  _WaterDropCityState createState() => _WaterDropCityState();
}

class _WaterDropCityState extends State<WaterDropCity> {
  int waterDrops = 300;
  int population = 0;
  List<PlacedBuilding> placedBuildings = [];
  BuildingType? selectedBuildingType;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startGameLoop();
  }

  void startGameLoop() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        collectWater();
        updateBuildings();
        updatePopulation();
      });
    });
  }

  void collectWater() {
    waterDrops += placedBuildings.where((b) => b.type == BuildingType.waterCollector).length * 2;
  }

  void updateBuildings() {
    for (var building in placedBuildings) {
      if (building.water < building.maxWater) {
        building.water = (building.water + 1).clamp(0, building.maxWater);
      }
    }
  }

  void updatePopulation() {
    population = placedBuildings.where((b) => b.type == BuildingType.house).length * 10;
  }

  void placeBuilding(Offset position) {
    if (selectedBuildingType != null && waterDrops >= 50) {
      setState(() {
        placedBuildings.add(PlacedBuilding(
          type: selectedBuildingType!,
          position: position,
          water: 0,
          maxWater: selectedBuildingType == BuildingType.waterCollector ? 100 : 50,
        ));
        waterDrops -= 50;
        selectedBuildingType = null;
      });
    }
  }

  void upgradeBuilding(PlacedBuilding building) {
    if (waterDrops >= 100 && !building.isUpgraded) {
      setState(() {
        building.isUpgraded = true;
        building.maxWater *= 2;
        waterDrops -= 100;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildStatusBar(),
          Expanded(
            child: buildCityView(),
          ),
          buildControlPanel(),
        ],
      ),
    );
  }

  Widget buildStatusBar() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.blue,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('💧 $waterDrops', style: TextStyle(color: Colors.white, fontSize: 18)),
            Text('👥 $population', style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget buildCityView() {
    return GestureDetector(
      onTapUp: (details) {
        placeBuilding(details.localPosition);
      },
      child: Stack(
        children: [
          Image.asset(
            'assets/images/dashland.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Placed buildings
          ...placedBuildings.map((building) => Positioned(
            left: building.position.dx - 25,
            top: building.position.dy - 25,
            child: GestureDetector(
              onTap: () => upgradeBuilding(building),
              child: buildingWidget(building),
            ),
          )),
          // Selected building preview
          if (selectedBuildingType != null)
            Positioned(
              left: 10,
              top: 10,
              child: buildingWidget(PlacedBuilding(
                type: selectedBuildingType!,
                position: Offset.zero,
                water: 0,
                maxWater: 50,
              )),
            ),
        ],
      ),
    );
  }

  Widget buildingWidget(PlacedBuilding building) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: building.type.color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: building.isUpgraded ? Colors.yellow : Colors.white,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(building.type.icon, size: 24, color: Colors.white),
          Text(
            '${building.water}/${building.maxWater}',
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget buildControlPanel() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: BuildingType.values.map((type) {
          return ElevatedButton(
            onPressed: () => setState(() => selectedBuildingType = type),
            child: Icon(type.icon),
            style: ElevatedButton.styleFrom(),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

enum BuildingType {
  waterCollector,
  house,
  farm,
  factory,
}

extension BuildingTypeExtension on BuildingType {
  IconData get icon {
    switch (this) {
      case BuildingType.waterCollector:
        return Icons.opacity;
      case BuildingType.house:
        return Icons.home;
      case BuildingType.farm:
        return Icons.grass;
      case BuildingType.factory:
        return Icons.factory;
    }
  }

  Color get color {
    switch (this) {
      case BuildingType.waterCollector:
        return Colors.blue;
      case BuildingType.house:
        return Colors.green;
      case BuildingType.farm:
        return Colors.brown;
      case BuildingType.factory:
        return Colors.grey;
    }
  }
}

class PlacedBuilding {
  final BuildingType type;
  final Offset position;
  int water;
  int maxWater;
  bool isUpgraded;

  PlacedBuilding({
    required this.type,
    required this.position,
    required this.water,
    required this.maxWater,
    this.isUpgraded = false,
  });
}