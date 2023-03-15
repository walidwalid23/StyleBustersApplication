import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylebusters/core/utils/constants/colors_manager.dart';
import 'package:stylebusters/presentation/reusable_widgets/DefaultFormField.dart';
import 'package:stylebusters/presentation/reusable_widgets/show_image.dart';

class ClothesScreen extends StatefulWidget {
   ClothesScreen({Key? key}) : super(key: key);

  @override
  State<ClothesScreen> createState() => _ClothesScreenState();
}

class _ClothesScreenState extends State<ClothesScreen> {
   var key =GlobalKey<ScaffoldState>();

   final ImagePicker pickimage = ImagePicker();

   File? uploadimage;

   File? logoimage;

   var Formkey = GlobalKey<FormState>();

   var emailController = TextEditingController();

   bool isBottomSheetShown = false;

  @override
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
        children: [
          // Center(
          //   child: Padding(
          //     padding: const EdgeInsets.all(20.0),
          //     child: Container(
          //       width: 500,
          //       height: 500,
          //       decoration: BoxDecoration(
          //         image: DecorationImage(
          //           image: AssetImage('assets/images/blankimage.png'),
          //         )
          //       ),
          //     ),
          //   ),
          // ),
          // CarouselSlider(
          //   items:,
          //   options: CarouselOptions(
          //     viewportFraction: 1,
          //     height: 250,
          //     initialPage: 0,
          //     enableInfiniteScroll: true,
          //     reverse: false,
          //     autoPlay: false,
          //     autoPlayInterval: Duration(seconds: 3),
          //     autoPlayAnimationDuration: Duration(seconds: 1),
          //     autoPlayCurve: Curves.fastOutSlowIn,
          //     scrollDirection: Axis.horizontal,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 500,
              height: 500,
              child: (logoimage==null)?Center(
                child: Text(
                  "Upload Image to Show Similar Logos",
                  style: TextStyle(
                    fontSize: 23.0,
                  ),
                ),
              ) :Image.file(logoimage!),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(isBottomSheetShown){
            Navigator.pop(context);
            isBottomSheetShown=false;
          }
          else{
            key.currentState!.showBottomSheet((context) => Container(
              width: double.infinity,
              height: 300.0,
              color: Colors.grey[100],
              child: Form(
                key: Formkey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
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
                ),
              ),
            ));
            isBottomSheetShown=true;
          }
        },
        child:Icon(
            Icons.add
        ),
      ),
    );
  }
}
