import 'package:flame/components.dart';

import 'package:waterdropdash/provider/building.dart';

class PlacedBuilding {
  final Building building;
  Vector2 position;
  int waterLevel;

  PlacedBuilding({required this.building, required this.position, this.waterLevel = 0});
}