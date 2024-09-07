import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:waterdropdash/provider/GameState.dart';

import 'package:waterdropdash/provider/avtarProvider.dart';
import 'package:waterdropdash/provider/soundProvider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<String> avatars = List.generate(8, (index) => 'dash${index + 1}.png');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF001C38),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.lightBlue),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                'Customize',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Consumer<AvatarProvider>(
                      builder: (context, avatarProvider, child) {
                        return GridView.builder(
                          padding: EdgeInsets.all(16),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: avatars.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                avatarProvider.setAvatar(avatars[index]);
                                // print(avatars[index]);
                                print(avatarProvider.selectedAvatar);
                                
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: avatarProvider.selectedAvatar == avatars[index] ? Colors.yellow : Colors.transparent,
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset('assets/images/${avatars[index]}'),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Save'),
                    onPressed: () {
                      
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: Size(200, 40),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 300,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFF2A4A5F),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.lightBlue, width: 2),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'SETTINGS',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Consumer<SoundProvider>(
                          builder: (context, soundProvider, child) {
                            return _buildSettingRow('MUSIC', soundProvider.soundEnabled, (value) {
                              soundProvider.toggleSound();
                            });
                          },
                        ),
                    
                        SizedBox(height: 20),
                     
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow(String title, bool isOn, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        Container(
          width: 60,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[800],
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                left: isOn ? 30 : 0,
                right: isOn ? 0 : 30,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () => onChanged(!isOn),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isOn ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
