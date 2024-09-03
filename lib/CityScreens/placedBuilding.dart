import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:waterdropdash/CityScreens/water_level_indicator.dart';
import 'package:waterdropdash/Model/placedBuilding.dart';


class PlacedBuildingComponent extends PositionComponent {
  final PlacedBuilding building;
  final VoidCallback onRestore;

  PlacedBuildingComponent({required this.building, required this.onRestore}) 
      : super(position: building.position, size: Vector2.all(building.building.size.width));

  @override
  Future<void> onLoad() async {
    final sprite = await Sprite.load(building.building.imagePath);
    add(SpriteComponent(sprite: sprite, size: size));
    
    add(WaterLevelIndicator(
      building: building,
      position: Vector2(0, size.y),
      size: Vector2(size.x, 10),
    ));

    add(TextComponent(
      text: 'Restore',
      position: Vector2(0, size.y + 15),
      textRenderer: TextPaint(style: TextStyle(color: Color(0xFF0000FF), fontSize: 12)),
    ));
  }

  @override
  bool onTapDown(TapDownInfo info) {
    onRestore();
    return true;
  }
}