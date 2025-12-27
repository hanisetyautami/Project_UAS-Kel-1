import 'package:flutter/material.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mediaquery untuk responsivitas
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.eco, size: 80, color: Color(0xFF4CAF50)),
              const SizedBox(height: 20),
              const Text(
                "PETUNGNI",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF4CAF50)),
              ),
              const SizedBox(height: 40),
              
              // Tombol Login Petani
              _buildRoleButton(
                context, 
                title: "Masuk sebagai Petani", 
                role: "Petani", 
                color: const Color(0xFF4CAF50),
                width: screenWidth
              ),
              const SizedBox(height: 15),
              
              // Tombol Login Konsumen
              _buildRoleButton(
                context, 
                title: "Masuk sebagai Konsumen", 
                role: "Konsumen", 
                color: Colors.orange,
                width: screenWidth
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, {required String title, required String role, required Color color, required double width}) {
    return SizedBox(
      width: width,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen(role: role)),
          );
        },
        child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}