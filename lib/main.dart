import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stylebusters/core/utils/constants/theme_manager.dart';
import 'package:stylebusters/presentation/screens/logos_screen.dart';
import 'package:stylebusters/presentation/screens/main_screen.dart';

void main() {
  runApp(ProviderScope(child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppThemeManager.lightMode,
      home: LogosScreen(),
    );
  }
}



