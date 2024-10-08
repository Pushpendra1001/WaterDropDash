import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/text.dart';
import 'package:flame/collisions.dart';
import 'package:waterdropdash/provider/GameState.dart';


class DashGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Player player;
  late ParallaxComponent background;
  late TextComponent scoreDisplay;
  late TextComponent taskDisplay;
  late TextComponent livesDisplay;
  late TextComponent comboDisplay;
  late TextComponent timerDisplay;
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
  int comboCount = 0;
  double comboMultiplier = 1.0;
  double remainingTime = 30.0;
  final AvatarProvider avatarProvider;
  late double baseTextSize;

  static const List<double> lanes = [-100, 0, 100];

  DashGame({required this.currentLevel, required this.waterBottleTarget ,  required this.avatarProvider,}) {
    gameSpeed = 2.0 + (currentLevel * 0.1);
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
    comboCount = 0;
    comboMultiplier = 1.0;
    removeAll(children.whereType<Item>());
    remainingTime = 30.0;
    overlays.clear();
    
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
   baseTextSize = size.x * 0.04;

    background = await loadParallaxComponent(
      [ParallaxImageData('background.png')],
      baseVelocity: Vector2.zero(),
      repeat: ImageRepeat.repeatY,
      fill: LayerFill.height,
      alignment: Alignment.center
    );
    add(background);

    player = Player(avatarProvider: avatarProvider);
    add(player);

      scoreDisplay = createTextComponent(
      'Score: 0',
      Vector2(size.x * 0.95, size.y * 0.05),
      anchor: Anchor.topRight,
      fontSize: baseTextSize,
    );

    timerDisplay = createTextComponent(
      'Time: 30.0',
      Vector2(size.x * 0.5, size.y * 0.05),
      anchor: Anchor.topCenter,
      fontSize: baseTextSize,
    );

    taskDisplay = createTextComponent(
      'Water: 0 / $waterBottleTarget',
      Vector2(size.x * 0.05, size.y * 0.05),
      anchor: Anchor.topLeft,
      fontSize: baseTextSize,
    );

    livesDisplay = createTextComponent(
      'Lives: 3',
      Vector2(size.x * 0.05, size.y * 0.1),
      anchor: Anchor.topLeft,
      fontSize: baseTextSize,
    );

    comboDisplay = createTextComponent(
      'Combo: x1.0',
      Vector2(size.x * 0.95, size.y * 0.1),
      anchor: Anchor.topRight,
      fontSize: baseTextSize * 0.8,
      color: Colors.yellow,
    );

    add(scoreDisplay);
    add(timerDisplay);
    add(taskDisplay);
    add(livesDisplay);
    add(comboDisplay);

    _spawnItems();
  }

   TextComponent createTextComponent(
    String text,
    Vector2 position, {
    Anchor anchor = Anchor.topLeft,
    double fontSize = 24,
    Color color = Colors.white,
  }) {
    return TextComponent(
      text: text,
      position: position,
      anchor: anchor,
      textRenderer: TextPaint(
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // void _spawnItems() {
  //   final itemSpawner = TimerComponent(
  //     period: 1.0 / gameSpeed,
  //     repeat: true,
  //     onTick: () {
  //       final itemType = ItemType.values[random.nextInt(ItemType.values.length)];
  //       add(Item(type: itemType));
  //     },
  //   );
  //   add(itemSpawner);
  // }
   void _spawnItems() {
    final itemSpawner = TimerComponent(
      period: 1.0 / gameSpeed,
      repeat: true,
      onTick: () {
        
        double powerUpChance = 0.10; 

        if (random.nextDouble() < powerUpChance) {
          add(Item(type: ItemType.powerUp));
        } else {
         
          List<ItemType> regularItems = ItemType.values.where((type) => type != ItemType.powerUp).toList();
          final itemType = regularItems[random.nextInt(regularItems.length)];
          add(Item(type: itemType));
        }
      },
    );
    add(itemSpawner);
  }

  @override
  void update(double dt) {
    if (!isGamePaused) {
      super.update(dt);
      scoreDisplay.text = 'Score: $score';
      taskDisplay.text = 'Water: $waterBottlesCollected / $waterBottleTarget';
      livesDisplay.text = 'Lives: $lives';
      comboDisplay.text = 'Combo: x${comboMultiplier.toStringAsFixed(1)}';

    if (waterBottlesCollected >= waterBottleTarget) {
      showRewardScreen(100, 'AQUA' , currentLevel); // Adjust reward amount as needed
    }

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

       remainingTime -= dt;
      if (remainingTime <= 0) {
        remainingTime = 0;
        isGamePaused = true;
        overlays.add('gameOver');
      }

       scoreDisplay.text = 'Score: $score';
      taskDisplay.text = 'Water: $waterBottlesCollected / $waterBottleTarget';
      livesDisplay.text = 'Lives: $lives';
      comboDisplay.text = 'Combo: x${comboMultiplier.toStringAsFixed(1)}';
      timerDisplay.text = 'Time: ${remainingTime.toStringAsFixed(1)}';
    }
  }

void showRewardScreen(int rewardAmount, String badgeName , int currentLevel) {
  isGamePaused = true;
  overlays.add('rewardScreen');
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
      comboCount = 0;
      comboMultiplier = 1.0;
      if (lives <= 0) {
        isGamePaused = true;
        overlays.add('gameOver');
      }
    }
  }

  void collectItem(ItemType type) {
    switch (type) {
      case ItemType.lemonTea:
        score += (1 * comboMultiplier).round();
        waterBottlesCollected += 1;
        increaseCombo();
        break;
      case ItemType.water:
        score += (2 * comboMultiplier).round();
        waterBottlesCollected += 1;
        increaseCombo();
        break;
      case ItemType.soda:
      case ItemType.wine:
      case ItemType.bottle:
        hitObstacle();
        break;
      case ItemType.powerUp:
        activatePowerUp();
        break;
    }
  }

  void increaseCombo() {
    comboCount++;
    if (comboCount % 5 == 0) {
      comboMultiplier += 0.5;
    }
  }

  void activatePowerUp() {
        isInvulnerable = true;
    invulnerabilityTimer = 0;
    player.opacity = 0.7;

    double extraTime = 2;
    remainingTime += extraTime;

    if (remainingTime > 30) {
      remainingTime = 30;
    }
  }
}

enum ItemType { lemonTea, water, soda, wine, bottle, powerUp }

class Item extends SpriteComponent with CollisionCallbacks, HasGameRef<DashGame> {
  final ItemType type;

  Item({required this.type}) : super(size: Vector2(48, 48));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(_getSpriteName());
    position = Vector2(
      gameRef.size.x / 2 + DashGame.lanes[gameRef.random.nextInt(3)],
      -size.y,
    );
    anchor = Anchor.center;
    add(RectangleHitbox());
  }

  String _getSpriteName() {
    switch (type) {
      case ItemType.lemonTea:
        return 'lemon-tea.png';
      case ItemType.water:
        return 'water1.png';
      case ItemType.soda:
        return 'soda.png';
      case ItemType.wine:
        return 'wine.png';
      case ItemType.bottle:
        return 'bottle.png';
      case ItemType.powerUp:
        return 'powerup.png';
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 300 * gameRef.gameSpeed * dt;
    if (position.y > gameRef.size.y + size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    
    if (other is Player) {
      gameRef.collectItem(type);
      removeFromParent();
    }
  }
}

class Player extends SpriteComponent with CollisionCallbacks, HasGameRef<DashGame> {
  int currentLane = 1;
  final AvatarProvider avatarProvider;
  Player({required this.avatarProvider}) : super(size: Vector2(100, 100));

  @override
  Future<void> onLoad() async {
    
    sprite = await gameRef.loadSprite(avatarProvider.selectedAvatar);
    print(AvatarProvider().selectedAvatar);
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
}