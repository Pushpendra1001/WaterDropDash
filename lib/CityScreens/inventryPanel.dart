// File: lib/widgets/inventory_panel.dart

import 'package:flutter/material.dart';
import 'package:waterdropdash/provider/building.dart';


class InventoryPanel extends StatelessWidget {
  final List<Building> inventory;
  final Function(Building) onSelectBuilding;

  InventoryPanel({required this.inventory, required this.onSelectBuilding});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 100,
        color: Colors.black.withOpacity(0.5),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: inventory.map((building) {
            return GestureDetector(
              onTap: () => onSelectBuilding(building),
              child: Container(
                margin: EdgeInsets.all(8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(building.imagePath, width: 50, height: 50),
                    Text(building.name),
                    Text('${building.cost}'),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}