import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylebusters/core/utils/constants/colors_manager.dart';
import 'package:stylebusters/presentation/reusable_widgets/DefaultFormField.dart';
import 'package:stylebusters/presentation/reusable_widgets/show_image.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ArtworksScreen extends StatefulWidget {
  ArtworksScreen({Key? key}) : super(key: key);

  @override
  State<ArtworksScreen> createState() => _ArtworksScreenState();
}

class _ArtworksScreenState extends State<ArtworksScreen> {
  @override
  var key = GlobalKey<ScaffoldState>();
  final ImagePicker pickimage = ImagePicker();
  File? uploadimage;
  File? artworkimage;
  var Formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  bool isBottomSheetShown = false;
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 79, 143),
      key: key,
      appBar: AppBar(
        title: Center(
          child: Text("Artworks"),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(100.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Colors.amber,
              ),
              width: 300,
              height: 150,
              child: (artworkimage == null)
                  ? Center(
                      child: Text(
                        "Upload Image to Show Similar Artworks",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 23.0,
                        ),
                      ),
                    )
                  : Image.file(artworkimage!),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMaterialModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            backgroundColor: Colors.white,
            context: context,
            builder: (context) => SingleChildScrollView(
              controller: ModalScrollController.of(context),
              child: Container(
                height: screenheight * 0.45,
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
                          onPressed: () async {
                            final image = await pickimage.pickImage(
                                source: ImageSource.gallery);
                            if (image == null) {
                              return;
                            }
                            setState(() {
                              uploadimage = File(image.path);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.themeColor1),
                          child: const Text('Upload Logo Image'),
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
                          Label: "Email*",
                          type: TextInputType.visiblePassword,
                          Controller: emailController,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.themeColor1),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        hoverColor: ColorsManager.themeColor2,
        child: Icon(Icons.add),
      ),
    );
  }
}
