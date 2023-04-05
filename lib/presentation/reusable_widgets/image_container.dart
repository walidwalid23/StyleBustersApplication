import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class ImageContainer extends StatelessWidget {
  ImageContainer({Key? key,this.uploadedImage, required this.width, required this.height}) : super(key: key);

  File? uploadedImage;
  double width;
  double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      child: (uploadedImage==null)?Image.asset('assets/images/blankimage.png') :Image.file(uploadedImage!),
    );
  }
}
