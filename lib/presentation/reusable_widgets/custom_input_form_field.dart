import 'package:flutter/material.dart';

class CustomTextInputField extends StatelessWidget {
  CustomTextInputField(
      {Key? key,
      required this.hintText,
      required this.validatorFunc,
      required this.textFieldController,
      required this.label})
      : super(key: key);
  String hintText;
  Widget label;
  String? Function(String? value) validatorFunc;
  TextEditingController textFieldController;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          controller: textFieldController,
          maxLength: 60,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            label: label,
            hintText: hintText,
            labelStyle: TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          validator: validatorFunc,
        ));
  }
}
