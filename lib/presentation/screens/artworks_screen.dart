import 'package:flutter/material.dart';

class ArtworksScreen extends StatelessWidget {
  ArtworksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Artworks"),
        ),
      ),
      body: Center(
        child: Text("Artworks Screen"),
      ),
    );
  }
}
