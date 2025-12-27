import 'package:flutter/material.dart';
import 'consumer_dashboard_screen.dart';
import 'farmer_notification_screen.dart'; 
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  final String role; 
  const LoginScreen({super.key, required this.role});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  void _processLogin() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim().toLowerCase();

      // Logika akun demo
      if (email.contains("petani") || email == "pakslamet@gmail.com") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const FarmerNotificationScreen(farmerName: "Pak Slamet"),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ConsumerDashboard()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Color themeColor = widget.role.toLowerCase() == 'petani' ? Colors.green : Colors.orange;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER PETUNGNI
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 60),
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "PETUNGNI",
                    style: TextStyle(
                      fontSize: 35, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.white,
                      letterSpacing: 1.5
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Login sebagai ${widget.role}",
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        prefixIcon: Icon(Icons.email, color: themeColor),
                      ),
                      validator: (value) => value!.isEmpty ? "Email wajib diisi" : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        prefixIcon: Icon(Icons.lock, color: themeColor),
                      ),
                      validator: (value) => value!.isEmpty ? "Password wajib diisi" : null,
                    ),
                    
                    // Remember Me & Forgot Password
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe, 
                          activeColor: themeColor,
                          onChanged: (v) => setState(() => _rememberMe = v!)
                        ),
                        const Text("Ingat Saya"),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            // Dialog Lupa Password
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Lupa Password"),
                                content: const Text("Fitur reset akan dikirim ke email Anda."),
                                actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
                              ),
                            );
                          },
                          child: const Text("Lupa Password?", style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // TOMBOL LOGIN
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: _processLogin,
                        child: const Text("LOGIN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // TOMBOL REGISTER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Belum punya akun?"),
                        TextButton(
                          onPressed: () {
                            // Kirim nama otomatis
                            String autoName = widget.role.toLowerCase() == 'petani' ? "Pak Slamet" : "Budi Santoso";
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(role: widget.role, initialName: autoName),
                              ),
                            );
                          },
                          child: Text("Daftar di sini", style: TextStyle(color: themeColor, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}