import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stylebusters/presentation/screens/artworks_screen.dart';
import 'package:stylebusters/presentation/screens/clothes_screen.dart';
import 'package:stylebusters/presentation/screens/home_screen.dart';
import 'package:stylebusters/presentation/screens/logos_screen.dart';
import 'package:stylebusters/presentation/screens/main_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return MainScreen();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return HomeScreen();
      },
    ),
    GoRoute(
      path: '/logos',
      builder: (BuildContext context, GoRouterState state) {
        return LogosScreen();
      },
    ),
    GoRoute(
      path: '/clothes',
      builder: (BuildContext context, GoRouterState state) {
        return ClothesScreen();
      },
    ),
    GoRoute(
      path: '/artworks',
      builder: (BuildContext context, GoRouterState state) {
        return ArtworksScreen();
      },
    ),
  ],
);