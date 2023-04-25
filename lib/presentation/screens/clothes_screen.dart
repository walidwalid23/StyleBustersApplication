import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylebusters/core/utils/constants/colors_manager.dart';
import 'package:stylebusters/presentation/reusable_widgets/DefaultFormField.dart';
import 'package:stylebusters/presentation/reusable_widgets/show_image.dart';

import '../reusable_widgets/home_drawer.dart';

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
   String dropdownValue = "select";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(
              "Find Similar Clothes",
          ),
        centerTitle: true,
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
                  "Upload Image to Show Similar Clothes",
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
              height: 465.0,
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
                       DropdownButtonFormField(
                            value: dropdownValue,
                            items:[
                              DropdownMenuItem<String>(
                              value: "select",
                              child: Text("Select Clothes' Gender",
                                  style: TextStyle(color: Colors.grey)),
                              enabled: false,
                              ),
                              DropdownMenuItem<String>(
                                value: "all",
                                child: Text("All Genders",
                                    style: TextStyle(color: Colors.black)),
                              ),
                              DropdownMenuItem<String>(
                                value: "Male",
                                child: Text("Male",
                                    style: TextStyle(color: Colors.black)),
                              ),
                              DropdownMenuItem<String>(
                                value: "Female",
                                child: Text("Female",
                                    style: TextStyle(color: Colors.black)),
                              ),

                            ],
                            onChanged: (value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                            },
                            validator: (value) {
                              if (value == null || value == 'select') {
                                return 'Please Select A Country';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                            ),
                          ),
                      SizedBox(
                        height: 10,
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
      drawer: const HomeDrawer(),
    );
  }
}
