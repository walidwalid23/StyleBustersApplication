import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class ShowImage extends StatelessWidget {
  ShowImage({Key? key,this.image}) : super(key: key);
  File? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: (image==null)?Image.asset('assets/images/blankimage.png') :Image.file(image!),
    );
  }
}