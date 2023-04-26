import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
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
   File? clothesimage;
   final List<Map<String, dynamic>> gridMap = [
     {
       "title": "white sneaker with adidas logo",
       "price": "\$255",
       "images":
       "https://images.unsplash.com/photo-1600185365926-3a2ce3cdb9eb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=725&q=80",
     },
     {
       "title": "Black Jeans with blue stripes",
       "price": "\$245",
       "images":
       "https://images.unsplash.com/photo-1541099649105-f69ad21f3246?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
     },
     {
       "title": "Red shoes with black stripes",
       "price": "\$155",
       "images":
       "https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c2hvZXN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
     },
     {
       "title": "Gamma shoes with beta brand.",
       "price": "\$275",
       "images":
       "https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
     },
     {
       "title": "Alpha t-shirt for alpha testers.",
       "price": "\$25",
       "images":
       "https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
     },
     {
       "title": "Beta jeans for beta testers",
       "price": "\$27",
       "images":
       "https://images.unsplash.com/photo-1602293589930-45aad59ba3ab?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
     },
     {
       "title": "V&V  model white t shirts.",
       "price": "\$55",
       "images":
       "https://images.unsplash.com/photo-1554568218-0f1715e72254?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
     }
   ];
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 500,
              height: 500,
              child: (gridMap==null)?Center(
                child: Text(
                  "Upload Image to Show Similar Clothes",
                  style: TextStyle(
                    fontSize: 23.0,
                  ),
                ),
                ):SingleChildScrollView(
                  child: Column(
                    children: [
                      GridView.builder(
                            physics:ScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12.0,
                              mainAxisSpacing: 12.0,
                              mainAxisExtent: 310,
                              ),
                            itemCount: gridMap.length,
                            itemBuilder: (_, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    16.0,
                                  ),
                                  color: Colors.deepOrange,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                      child: CachedNetworkImage(
                                        progressIndicatorBuilder: (context, url, progress) => Center(
                                          child: CircularProgressIndicator(
                                            value: progress.progress,
                                          ),
                                        ),
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        imageUrl: "${gridMap.elementAt(index)['images']}",
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${gridMap.elementAt(index)['title']}",
                                            style: Theme.of(context).textTheme.subtitle1!.merge(
                                              const TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Text(
                                            "${gridMap.elementAt(index)['price']}",
                                            style: Theme.of(context).textTheme.subtitle2!.merge(
                                              TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        child: const Text('Load More'),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.themeColor1
                        ),
                      ),
                    ],
                  ),
                ),
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
