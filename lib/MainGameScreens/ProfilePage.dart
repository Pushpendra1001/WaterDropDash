import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:waterdropdash/Model/FirebaseService.dart';
import 'package:waterdropdash/Model/UserModel.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return FutureBuilder<UserModel>(
      future: UserService().getUserData(user.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error fetching user data'),
            ),
          );
        }

        final userData = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
            backgroundColor: Colors.blueAccent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/avatar.png'), // Provide a default image
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Name: ${userData.name}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Email: ${userData.email}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  'Target Water Intake: ${userData.targetWaterIntake} ml',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement logout functionality
                    },
                    child: Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
