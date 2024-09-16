import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardScreen extends StatelessWidget {
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
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .orderBy('UserTotalScore', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No data available'));
            }

            final leaderboardData = snapshot.data!.docs.map((doc) {
              return {
                'rank': 0, // Placeholder, will be set later
                'name': doc['username'],
                'points': doc['UserTotalScore'],
                'icon': Icons.eco, // Default icon, you can customize this
                'color': Colors.blue, // Default color, you can customize this
              };
            }).toList();

            // Assign ranks
            for (int i = 0; i < leaderboardData.length; i++) {
              leaderboardData[i]['rank'] = i + 1;
            }

            return ListView.builder(
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
            );
          },
        ),
      ),
    );
  }
}