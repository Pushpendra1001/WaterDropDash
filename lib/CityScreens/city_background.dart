import 'package:flame/components.dart';

class CityBackground extends SpriteComponent {
  CityBackground() : super(size: Vector2(2000, 2000));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('assets/dashland.png');
  }
}