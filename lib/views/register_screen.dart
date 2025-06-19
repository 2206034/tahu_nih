import 'package:flutter/material.dart';
import 'package:tahu_nih/views/auth_check_screen.dart';
import 'package:tahu_nih/views/login_screen.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF3EDED), // warna input dari gambar
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: const Center(
                  child: Text(
                    'Daftar Yuk !',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Ayo Segera daftar',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 32),

              // Username
              TextField(
                decoration: inputDecoration.copyWith(
                  hintText: 'Masukan Username',
                ),
              ),
              const SizedBox(height: 24),

              // Email / Phone
              TextField(
                decoration: inputDecoration.copyWith(
                  hintText: 'Email / Phone',
                ),
              ),
              const SizedBox(height: 24),

              // Password
              TextField(
                obscureText: true,
                decoration: inputDecoration.copyWith(
                  hintText: 'Masukan Password',
                ),
              ),
              const SizedBox(height: 24),

              // Konfirmasi Password
              TextField(
                obscureText: true,
                decoration: inputDecoration.copyWith(
                  hintText: 'Konfirmasi Password',
                ),
              ),
              const SizedBox(height: 48),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Logika sign up nanti ditaruh di sini
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 139, 172, 243),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Regis Now
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AuthCheckScreen()),
                    );
                  },
                  child: const Text(
                    'Login Now',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
