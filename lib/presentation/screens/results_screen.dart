import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stylebusters/presentation/reusable_widgets/home_drawer.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
File? clothesimage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child: Container(
        width: 500,
        height: 500,
        child: (clothesimage==null)?Center(
          child: Text(
            "No Results Found Click More to Search for more results",
            style: TextStyle(
              fontSize: 23.0,
            ),
          ),
        ):Image.file(clothesimage!),
      )
      ),
      drawer: const HomeDrawer(),
    );
  }
}
