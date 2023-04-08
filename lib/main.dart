import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stylebusters/core/routing/gorouter.dart';
import 'package:stylebusters/core/utils/constants/theme_manager.dart';

void main() {

  runApp(ProviderScope(child:MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'StyleBusters',
      theme: AppThemeManager.lightMode,
      routerConfig: appRouter,
    );
  }
}



