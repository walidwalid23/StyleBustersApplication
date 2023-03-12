import 'package:flutter/material.dart';
import 'package:stylebusters/core/utils/constants/colors_manager.dart';

class DefaultTextFormField extends StatelessWidget {
  DefaultTextFormField({
    Key? key,
    required this.type,
    required this.Controller,
    required this.hintText,
    required this.validate,
    required this.prefix,
    this.showPassword = false,
    this.iconSwitch,
    this.suffix,
  }) : super(key: key);
  TextEditingController Controller;
  TextInputType type;
  String hintText;
  var validate;
  IconData prefix;
  var suffix;
  bool showPassword;
  var iconSwitch;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validate,
      controller: Controller,
      keyboardType: type,
      cursorColor: Colors.black,
      obscureText: showPassword,
      maxLength: 50,
      decoration: InputDecoration(
        hintText: "${hintText}",
        prefixIcon: Icon(prefix, color: ColorsManager.themeColor1),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: iconSwitch,
          icon: Icon(suffix),
          color: Colors.black,
        )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(width: 1, color: ColorsManager.themeColor1!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(width: 1, color: Colors.blue[800]!),
        ),
        //fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}