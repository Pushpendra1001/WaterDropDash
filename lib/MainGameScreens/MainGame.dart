import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
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
  bool isInvulnerable = false;
  double invulnerabilityTimer = 0;
  static const double invulnerabilityDuration = 2.0;
  final Random random = Random();
  

  static const List<double> lanes = [-100, 0, 100];

  DashGame({required this.currentLevel, required this.waterBottleTarget}) {
    gameSpeed = 1.0 + (currentLevel * 0.1);
  }

  void reset() {
    score = 0;
    waterBottlesCollected = 0;
    lives = 3;
    isGamePaused = false;
    isInvulnerable = false;
    invulnerabilityTimer = 0;
    player.currentLane = 1;
    player.opacity = 1.0;
    removeAll(children.whereType<Obstacle>());
    removeAll(children.whereType<EnergyBottle>());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    background = await loadParallaxComponent(
      [ParallaxImageData('background.png')],
      baseVelocity: Vector2.zero(),
      repeat: ImageRepeat.repeatY,
      fill: LayerFill.height,
      alignment: Alignment.center
    );
    add(background);

    player = Player();
    add(player);

    scoreDisplay = TextComponent(
      text: 'Score: 0',
      position: Vector2(size.x - 50, 50),
      anchor: Anchor.topRight,
      textRenderer: TextPaint(style: const TextStyle(color: Colors.white, fontSize: 24)),
    );
    add(scoreDisplay);

    taskDisplay = TextComponent(
      text: 'Water: 0 / $waterBottleTarget',
      position: Vector2(20, 50),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(style: const TextStyle(color: Colors.white, fontSize: 24)),
    );
    add(taskDisplay);

    livesDisplay = TextComponent(
      text: 'Lives: 3',
      position: Vector2(size.x / 2, 50),
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(style: const TextStyle(color: Colors.white, fontSize: 24)),
    );
    add(livesDisplay);

    _spawnObstacles();
    _spawnEnergyBottles();
  }

  void _spawnObstacles() {
    final obstacleSpawner = TimerComponent(
      period: 1.5 / gameSpeed,
      repeat: true,
      onTick: () => add(Obstacle()),
    );
    add(obstacleSpawner);
  }

  void _spawnEnergyBottles() {
    final energyBottleSpawner = TimerComponent(
      period: 2 / gameSpeed,
      repeat: true,
      onTick: () => add(EnergyBottle()),
    );
    add(energyBottleSpawner);
  }

  @override
  void update(double dt) {
    if (!isGamePaused) {
      super.update(dt);
      scoreDisplay.text = 'Score: $score';
      taskDisplay.text = 'Water: $waterBottlesCollected / $waterBottleTarget';
      livesDisplay.text = 'Lives: $lives';

      if (isInvulnerable) {
        invulnerabilityTimer += dt;
        if (invulnerabilityTimer >= invulnerabilityDuration) {
          isInvulnerable = false;
          invulnerabilityTimer = 0;
          player.opacity = 1.0;
        }
      }

      if (waterBottlesCollected >= waterBottleTarget) {
        isGamePaused = true;
        overlays.add('levelComplete');
      }
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (!isGamePaused) {
      final touchPoint = info.eventPosition.global;
      if (touchPoint.x < size.x / 2) {
        player.moveLeft();
      } else {
        player.moveRight();
      }
    }
  }

  void hitObstacle() {
    if (!isInvulnerable) {
      lives--;
      isInvulnerable = true;
      player.opacity = 0.5;
      if (lives <= 0) {
        isGamePaused = true;
        overlays.add('gameOver');
      }
    }
  }

  void collectWater() {
    score += 10;
    waterBottlesCollected++;
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
      gameRef.hitObstacle();
    } else if (other is EnergyBottle) {
      gameRef.collectWater();
      other.removeFromParent();
    }
  }
}

class Obstacle extends SpriteComponent with CollisionCallbacks, HasGameRef<DashGame> {
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