import 'package:flame/components.dart';

class Building {
  final String name;
  final String imagePath;
  final int cost;
  final Vector2 size;

  Building({required this.name, required this.imagePath, required this.cost, required this.size});
}