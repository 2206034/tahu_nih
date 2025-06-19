import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 95, 177),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 95, 177),
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', width: 200,),
                Icon(Icons.person_outline_outlined, size: 100, color: Colors.white),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  margin: const EdgeInsets.only(top: 16.0),
                  width: 400,
                  child: const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
        
    );
  }
}