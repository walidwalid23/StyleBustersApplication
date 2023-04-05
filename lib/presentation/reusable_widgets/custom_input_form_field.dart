import 'package:stylebusters/core/utils/constants/colors_manager.dart';
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
        padding: const EdgeInsets.all(15),
        child: TextFormField(

          controller: textFieldController,
          maxLength: 60,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            label:label ,
            hintText: hintText,
            labelStyle: TextStyle(color: ColorsManager.themeColor1),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsManager.themeColor1!),
            ),
          ),
          validator: validatorFunc,
        ));
  }
}