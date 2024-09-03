import 'dart:ui';

import 'package:flame/components.dart';
import 'package:waterdropdash/Model/placedBuilding.dart';


class WaterLevelIndicator extends PositionComponent {
  final PlacedBuilding building;

  WaterLevelIndicator({required this.building, required Vector2 position, required Vector2 size})
      : super(position: position, size: size);

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Color(0xFF0000FF);
    final rect = Rect.fromLTWH(0, 0, size.x * (building.waterLevel / 30), size.y);
    canvas.drawRect(rect, paint);

    final borderPaint = Paint()
      ..color = Color(0xFF000000)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), borderPaint);
  }
}