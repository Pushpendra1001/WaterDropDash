import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class DropDashLandScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GameWidget(game: DropDashLandGame()),
          ),
          ShopSection(),
        ],
      ),
    );
  }
}

class DropDashLandGame extends FlameGame with PanDetector {
  late SpriteComponent background;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    background = SpriteComponent(
      sprite: await loadSprite('dashland.png'),
      size: Vector2(2000, 2000),
    );  
    add(background);

    camera.follow(background); // Corrected camera follow usage
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    camera.moveBy(info.delta.global); 
  }
}

class ShopSection extends StatelessWidget {
  final List<ShopItem> items = [
    ShopItem('House', 'assets/house_icon.png', 100),
    ShopItem('Factory', 'assets/factory_icon.png', 200),
    ShopItem('Park', 'assets/park_icon.png', 150),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.grey[300],
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ShopItemWidget(item: items[index]);
        },
      ),
    );
  }
}

class ShopItem {
  final String name;
  final String iconPath;
  final int cost;

  ShopItem(this.name, this.iconPath, this.cost);
}

class ShopItemWidget extends StatelessWidget {
  final ShopItem item;

  ShopItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(item.iconPath, width: 50, height: 50),
          Text(item.name, style: TextStyle(fontSize: 12)),
          Text('${item.cost} coins', style: TextStyle(fontSize: 10, color: Colors.blue)),
          ElevatedButton(
            child: Text('Buy', style: TextStyle(fontSize: 10)),
            onPressed: () {
              print('Bought ${item.name}');
            },
            style: ElevatedButton.styleFrom(padding: EdgeInsets.all(5)),
          ),
        ],
      ),
    );
  }
}


