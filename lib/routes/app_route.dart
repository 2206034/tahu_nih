import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tahu_nih/views/bookmark_screen.dart';
import 'package:tahu_nih/views/home_screen.dart';
import 'package:tahu_nih/views/splash_screen.dart';
import 'route_names.dart';

class AppRouter {
  AppRouter._();

  static final AppRouter _instance = AppRouter._();

  static AppRouter get instance => _instance;

  factory AppRouter() {
    // _instance.goRouter = goRouterSetup();
    return _instance;
  }

  late final GoRouter goRouter = goRouterSetup();

  static GoRouter goRouterSetup() {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          name: RouteNames.splash,
          pageBuilder: (context, state) => MaterialPage(child: SplashScreen()),
        ),
        GoRoute(
          path: '/home',
          name: RouteNames.home,
          pageBuilder: (context, state) => MaterialPage(child: HomeScreen()),
        ),
        GoRoute(
          path: '/bookmarks',
          name: RouteNames.bookmarks,
          pageBuilder: (context, GoRouterState state) {
            final args = state.extra as BookmarkScreenArgs?;

            if (args != null) {
              return MaterialPage(
                child: BookmarkScreen(bookmarkService: args.bookmarkService),
              );
            } else {
              return MaterialPage(
                child: Scaffold(appBar: AppBar(title: Text("error"))),
              );
            }
          },
        ),
      ],
    );
  }
}
