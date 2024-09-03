// // File: lib/services/city_storage.dart

// import 'dart:ui';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:waterdropdash/Model/placedBuilding.dart';
// import 'dart:convert';

// import 'package:waterdropdash/Model/building.dart';


// class CityStorage {
//   static Future<void> saveCity(List<PlacedBuilding> placedBuildings) async {
//     final prefs = await SharedPreferences.getInstance();
//     final cityData = placedBuildings.map((pb) => {
//       'name': pb.building.name,
//       'x': pb.position.dx,
//       'y': pb.position.dy,
//     }).toList();
//     await prefs.setString('city', jsonEncode(cityData));
//   }

//   static Future<List<PlacedBuilding>> loadCity(List<Building> inventory) async {
//     final prefs = await SharedPreferences.getInstance();
//     final cityString = prefs.getString('city');
//     if (cityString != null) {
//       final cityData = jsonDecode(cityString) as List;
//       return cityData.map((data) {
//         final building = inventory.firstWhere((b) => b.name == data['name']);
//         return PlacedBuilding(
//           building: building,
//           position: Offset(data['x'], data['y']),
//         );
//       }).toList();
//     }
//     return [];
//   }
// }