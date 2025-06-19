import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tahu_nih/routes/route_names.dart';
import 'package:tahu_nih/services/auth_service.dart';
import 'package:tahu_nih/views/home_screen.dart';
import 'package:tahu_nih/views/intro_screen.dart';
import 'package:tahu_nih/views/login_screen.dart';
import 'package:tahu_nih/views/profile_screen.dart';
import 'package:tahu_nih/views/register_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthAndNavigate();
    });
    // Future.delayed(const Duration(seconds: 3), () {
    //   if (mounted) {
    //     context.goNamed(RouteNames.intro);
    //   }
    // });
  }

  Future<void> _checkAuthAndNavigate() async {
    // Beri jeda agar splash screen terlihat
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.tryAutoLogin();

      if (mounted) {
        if (authService.isAuth) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => IntroScreen()),
          );
        }
      }
    }
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