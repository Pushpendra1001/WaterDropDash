import 'dart:ui';

import 'package:flame/components.dart';

class HudComponent extends PositionComponent {
  int waterDrops;
  int points;
  late TextComponent waterDropsText;
  late TextComponent pointsText;

  HudComponent({required this.waterDrops, required this.points}) : super(position: Vector2(10, 10));

  @override
  Future<void> onLoad() async {
    waterDropsText = TextComponent(
      text: 'Water: $waterDrops',
      textRenderer: TextPaint(style: TextPaint.defaultTextStyle),
    );
    add(waterDropsText);

    pointsText = TextComponent(
      text: 'Points: $points',
      textRenderer: TextPaint(style: TextPaint.defaultTextStyle),
      position: Vector2(0, 20),
    );
    add(pointsText);
  }

  void updateValues(int newWaterDrops, int newPoints) {
    waterDrops = newWaterDrops;
    points = newPoints;
    waterDropsText.text = 'Water: $waterDrops';
    pointsText.text = 'Points: $points';
  }
}