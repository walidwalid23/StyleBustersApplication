import 'package:flutter/material.dart';
import 'package:stylebusters/core/utils/constants/colors_manager.dart';

class DefaultFormField extends StatelessWidget {
  DefaultFormField({
    Key? key,
    required this.type,
    required this.Controller,
    required this.Label,
    required this.validate,
    required this.prefix,
    this.isPassword = false,
    this.icon,
    this.suffix,
  }) : super(key: key);
  TextEditingController Controller;
  TextInputType type;
  String Label;
  var validate;
  IconData prefix;
  var suffix;
  bool isPassword;
  var icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validate,
      controller: Controller,
      keyboardType: type,
      obscureText: isPassword,
      maxLength: 60,
      decoration: InputDecoration(
        labelText: "${Label}",
        prefixIcon: Icon(prefix, color: ColorsManager.themeColor1),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: icon,
          icon: Icon(suffix),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );
  }
}