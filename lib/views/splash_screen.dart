import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tahu_nih/routes/route_names.dart';
import 'package:tahu_nih/views/intro_screen.dart';
import 'package:tahu_nih/views/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 95, 177),
      body: Center(
        child: Image.asset('assets/images/logo.png', width: 200,),
      ),
    );
  }
}