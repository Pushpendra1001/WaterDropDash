import 'package:flutter/material.dart';


class LeaderboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> leaderboardData = [
    {'rank': 1, 'name': 'Kale', 'points': 150, 'icon': Icons.grass, 'color': Colors.purple},
    {'rank': 2, 'name': 'Vatani', 'points': 100, 'icon': Icons.emoji_nature, 'color': Colors.orange},
    {'rank': 3, 'name': 'Fahuts', 'points': 50, 'icon': Icons.waves, 'color': Colors.blue},
    {'rank': 4, 'name': 'Emmy', 'points': 50, 'icon': Icons.eco, 'color': Colors.green},
    {'rank': 5, 'name': 'Sida', 'points': 50, 'icon': Icons.eco, 'color': Colors.green},
    {'rank': 6, 'name': 'Kika', 'points': 50, 'icon': Icons.eco, 'color': Colors.green},
    {'rank': 7, 'name': 'Kubi', 'points': 50, 'icon': Icons.waves, 'color': Colors.green},
    {'rank': 8, 'name': 'Mani', 'points': 50, 'icon': Icons.eco, 'color': Colors.green},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Leaderboard',
          style: TextStyle(
            color: Colors.blue,
            fontFamily: 'PottaOne',
            fontSize: 24,
          ),
        ),
      ),
      body: Padding( 
padding: const EdgeInsets.all(16.0),
child: ListView.builder(
  itemCount: leaderboardData.length,
  itemBuilder: (context, index) {
    final player = leaderboardData[index];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          decoration: BoxDecoration(
            color: player['color'],
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(player['icon'], color: player['color']),
            ),
            title: Text(player['name']),
            subtitle: Text('Score: ${player['points']}'),
            trailing: Text('Rank: ${player['rank']}'),
          ),
        ),
      ),
    );
  },
),
    ));
  }
}
