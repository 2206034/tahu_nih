import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tahu_nih/services/auth_service.dart';
import 'package:tahu_nih/views/home_screen.dart';
import 'package:tahu_nih/views/my_news_screen.dart';
import 'package:tahu_nih/views/splash_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _handleLogOut() async {
    // Panggil metode logout dari AuthService
    await Provider.of<AuthService>(context, listen: false).logout();
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context, listen: false).user;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 95, 177),
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 27, 95, 177)),
      body: Column(
        children: [
          Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', width: 200),
                Icon(
                  Icons.person_outline_outlined,
                  size: 100,
                  color: Colors.white,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  margin: const EdgeInsets.only(top: 16.0),
                  width: 400,
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        user!.fullName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Text(
                        user!.email,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyNewsScreen()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    margin: const EdgeInsets.only(top: 16.0),
                    width: 400,
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'My News',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _handleLogOut,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    margin: const EdgeInsets.only(top: 16.0),
                    width: 200,
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Logout',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 221, 31, 31),
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.logout,
                          color: const Color.fromARGB(255, 221, 31, 31),
                        ),
                      ],
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
