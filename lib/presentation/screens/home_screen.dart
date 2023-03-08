import 'package:flutter/material.dart';

class ClothesScreen extends StatelessWidget {
  ClothesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Center(
        child: Text("Clothes Screen"),
      ),
    ),);
  }
}
