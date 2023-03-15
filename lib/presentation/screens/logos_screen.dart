import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylebusters/core/utils/constants/colors_manager.dart';
import 'package:stylebusters/presentation/reusable_widgets/DefaultFormField.dart';
import 'package:stylebusters/presentation/reusable_widgets/show_image.dart';

class LogosScreen extends StatefulWidget {
   LogosScreen({Key? key}) : super(key: key);

  @override
  State<LogosScreen> createState() => _LogosScreenState();
}
class _LogosScreenState extends State<LogosScreen> {
  @override
  var key =GlobalKey<ScaffoldState>();
  final ImagePicker pickimage = ImagePicker();
  File? uploadimage;
  File? logoimage;
  var Formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  bool isBottomSheetShown = false;
  Widget build(BuildContext context) {
    return Scaffold(
          key: key,
          appBar: AppBar(
            title: Center(
              child: Text(
                "Logos"
              ),
            ),
          ),
          body: Column(
          children:[
            ShowImage(
              image: uploadimage,
            ),
            ElevatedButton(
              child: const Text('Upload Logo Image'),
              onPressed: () async{
                final image = await pickimage.pickImage(
                    source: ImageSource.gallery
                );
                if(image == null){
                  return;
                }
                setState(() {
                  uploadimage = File(image.path);
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.themeColor1
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            DefaultFormField(
              prefix: Icons.email,
              validate: (value) {
                if (value!.isEmpty) {
                  return "Email must not be empty";
                }
                return null;
              },
              Label:"Email*" ,
              type: TextInputType.visiblePassword,
              Controller: emailController,
            ),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: (){},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.themeColor1
              ),
            ),
          ],
          ),
    );
}
}
