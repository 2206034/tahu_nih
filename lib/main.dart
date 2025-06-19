import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tahu_nih/routes/app_route.dart';
import 'package:tahu_nih/services/auth_service.dart';
import 'package:tahu_nih/services/favorite_service.dart';
import 'package:tahu_nih/services/news_service.dart';
import 'package:tahu_nih/views/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthService()),
        ChangeNotifierProvider(create: (ctx) => FavoriteService()),
        ChangeNotifierProvider(create: (ctx) => NewsService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tahu Nih News',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 27, 95, 177)),
            useMaterial3: true,
          ),
          // routerConfig: AppRouter().goRouter,
          home: SplashScreen(),
        );
      },
    );
  }
}
