import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/text.dart';
import 'package:flame/collisions.dart';

class DashGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Player player;
  late ParallaxComponent background;
  late TextComponent scoreDisplay;
  late TextComponent taskDisplay;
  late TextComponent livesDisplay;
  int score = 0;
  int currentLevel;
  int waterBottleTarget;
  int waterBottlesCollected = 0;
  int lives = 3;
  double gameSpeed = 1.0;
  bool isGamePaused = false;
  final Random random = Random();

  static const List<double> lanes = [-100, 0, 100];

  DashGame({required this.currentLevel, required this.waterBottleTarget}) {
    gameSpeed = 1.0 + (currentLevel * 0.1); // Increase speed with level
  }

  void reset() {
  score = 0;
  player.currentLane = 1;
  removeAll(children.whereType<Obstacle>());
  removeAll(children.whereType<EnergyBottle>());
}

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Load background
    background = await loadParallaxComponent(
      [ParallaxImageData('background.png' , )],
      baseVelocity: Vector2.zero(),
      repeat: ImageRepeat.repeatY,
      fill: LayerFill.height,
      alignment: Alignment.center

    );
    add(background);

    taskDisplay = TextComponent(
    text: 'Water: 0 / $waterBottleTarget',
    scale: NotifyingVector2(1, 2),
    position: Vector2(20, 50),
    anchor: Anchor.topLeft,
    textRenderer: TextPaint(
      style: const TextStyle(color: Colors.white, fontSize: 24),
    ),
  );
  add(taskDisplay);

    // Add player
    player = Player();
    add(player);

    // Add score display
    scoreDisplay = TextComponent(
      text: 'Score: 0',
      scale: NotifyingVector2(1, 2),
      position: Vector2(size.x - 20, 50),
      anchor: Anchor.topRight,
      textRenderer: TextPaint(
        style: const TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
    add(scoreDisplay);

    // Start spawning obstacles and energy bottles
    _spawnObstacles();
    _spawnEnergyBottles();
  }

  void _spawnObstacles() {
    final obstacleSpawner = TimerComponent(
      period: 2,
      repeat: true,
      onTick: () => add(Obstacle()),
    );
    add(obstacleSpawner);
  }

  void _spawnEnergyBottles() {
    final energyBottleSpawner = TimerComponent(
      period: 3,
      repeat: true,
      onTick: () => add(EnergyBottle()),
    );
    add(energyBottleSpawner);
  }

 @override
void update(double dt) {
  super.update(dt);
  scoreDisplay.text = 'Score: $score';
  taskDisplay.text = 'Water: $waterBottlesCollected / $waterBottleTarget';

  if (waterBottlesCollected >= waterBottleTarget) {
    overlays.add('levelComplete');
  }
}

@override
void onTapDown(TapDownInfo info) {
  final touchPoint = info.eventPosition.global;
  if (touchPoint.x < size.x / 2) {
    player.moveLeft();
  } else {
    player.moveRight();
  }
}
}



class Player extends SpriteComponent with CollisionCallbacks, HasGameRef<DashGame> {
  int currentLane = 1;

  Player() : super(size: Vector2(64, 64));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('dash.png');
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 100);
    anchor = Anchor.center;

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x = gameRef.size.x / 2 + DashGame.lanes[currentLane];
  }

  void moveLeft() {
    if (currentLane > 0) currentLane--;
  }

  void moveRight() {
    if (currentLane < 2) currentLane++;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
      
    if (other is Obstacle) {
      gameRef.overlays.add('gameOver');
    } else if (other is EnergyBottle) {
      gameRef.score += 10;
      other.removeFromParent();
    }
  }
}



class Obstacle extends SpriteComponent with CollisionCallbacks, HasGameRef<DashGame> {
  static const double _speed = 300;

  

  Obstacle() : super(size: Vector2(48, 48));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('bottle.png');
    position = Vector2(
      gameRef.size.x / 2 + DashGame.lanes[gameRef.random.nextInt(3)],
      -size.y,
    );
    anchor = Anchor.center;

    add(RectangleHitbox());
  }

    @override
  void update(double dt) {
    super.update(dt);
    position.y += 300 * gameRef.gameSpeed * dt;

    if (position.y > gameRef.size.y + size.y) {
      removeFromParent();
    }
  }
}

class EnergyBottle extends SpriteComponent with CollisionCallbacks, HasGameRef<DashGame> {
  static const double _speed = 250;

  EnergyBottle() : super(size: Vector2(32, 32));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('water.png');
    position = Vector2(
      gameRef.size.x / 2 + DashGame.lanes[gameRef.random.nextInt(3)],
      -size.y,
    );
    anchor = Anchor.center;

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 250 * gameRef.gameSpeed * dt;

    if (position.y > gameRef.size.y + size.y) {
      removeFromParent();
    }
  }
}