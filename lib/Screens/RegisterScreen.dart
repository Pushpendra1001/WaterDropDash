import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waterdropdash/GameMenuScreens/MainGameMenu.dart';
import 'package:waterdropdash/Screens/LoginScreen.dart';
import 'package:waterdropdash/WelcomeGameScreens/WelcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showAdditionalFields = false;
  String? selectedGender;
  String? selectedAge;
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': _emailController.text,
        'gender': selectedGender,
        'age': selectedAge,
        'target': _targetController.text,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "An error occurred")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100,),
              Center(child: Text("Register", style: GoogleFonts.pottaOne(fontSize: 40))),
              if (!showAdditionalFields) ...[
                Text("Email", style: TextStyle(fontSize: 24)),
                SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text("Password", style: TextStyle(fontSize: 24)),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text("Confirm password", style: TextStyle(fontSize: 24)),
                SizedBox(height: 10),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff04344D),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showAdditionalFields = true;
                          });
                        },
                        child: Text("Next", style: TextStyle(fontSize: 24, color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                   Center(child: Text("Already Have Account?", style: TextStyle(fontSize: 16))),
              Center(child: InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())),
                child: Text("Login", style: TextStyle(fontSize: 18, color: Colors.blue)),
              )),
              ] else ...[
                SizedBox(height: 30),
                Text("Gender", style: TextStyle(fontSize: 24)),
                SizedBox(height: 10),
                DropdownButton<String>(
                  value: selectedGender,
                  hint: Text("Select Gender"),
                  items: ["Male", "Female", "Other"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedGender = newValue;
                    });
                  },
                ),
                SizedBox(height: 30),
                Text("Age", style: TextStyle(fontSize: 24)),
                SizedBox(height: 10),
                DropdownButton<String>(
                  value: selectedAge,
                  hint: Text("Select Age"),
                  items: List.generate(100, (index) => (index + 1).toString()).map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedAge = newValue;
                    });
                  },
                ),
                SizedBox(height: 30),
                Text("What is your target? How much liter water you can drink in a day?", style: TextStyle(fontSize: 24)),
                SizedBox(height: 10),
                TextField(
                  controller: _targetController,
                  decoration: InputDecoration(
                    hintText: "Enter your target",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff04344D),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: _register,
                        child: Text("Sign Up", style: TextStyle(fontSize: 24, color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ],
              SizedBox(height: 30),
              Center(child: Text("Play as Guest?", style: TextStyle(fontSize: 16, color: Colors.blue))),
              Center(child: InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen())),
                child: Text("Skip", style: TextStyle(fontSize: 24, color: Colors.red)),
              )),
            ],
          ),
        ),
      ),
    );
  }
}