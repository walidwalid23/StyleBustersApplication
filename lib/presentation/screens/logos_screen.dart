import 'package:stylebusters/core/utils/constants/colors_manager.dart';
import 'package:stylebusters/core/utils/constants/styles_manager.dart';
import 'package:stylebusters/presentation/reusable_widgets/custom_input_form_field.dart';
import 'package:stylebusters/presentation/reusable_widgets/image_container.dart';
//import 'package:fakebustersapp/presentation/reusable_widgets/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../domain/entities/logo_entity.dart';
//import '../controller/post_providers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UploadPost extends ConsumerStatefulWidget {
  const UploadPost({Key? key}) : super(key: key);

  @override
  ConsumerState<UploadPost> createState() => _UploadPostState();
}

class _UploadPostState extends ConsumerState<UploadPost> {

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? logoImage;
  String imageValidationError = '';
  TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Logo'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextInputField(
              hintText: "Enter Your Email",
              label:const Text("Email*"),
                validatorFunc: (value) {
                  if (value == null || value.isEmpty) {
                    return 'You Cannot Leave The Email Field Empty';
                  } else if (value.length > 60) {
                    return 'Exceeded Maximum Characters Length';
                  }
                  return null;
                },
                textFieldController: emailController ,
              ),

              ImageContainer(
                uploadedImage: logoImage,
                width: 200,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  child: const Text('Upload Logo Image'),
                  onPressed: () async {
                    final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);
                    if (image == null) {
                      return;
                    }
                    setState(() {
                      logoImage = File(image.path);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.themeColor1),
                ),
              ),
              Center(
                  child: Text(
                    imageValidationError,
                    style: StylesManager.notificationStyle,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 80, right: 80),
                child: ElevatedButton(
                  child: Text(
                    'Submit',
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        logoImage != null) {
                      // DATA IS VALID
                      Logo postData = Logo(
                          uploaderEmail: emailController.text,
                          logoImage: logoImage!,
                        );
                      // upload the post
                      ref.read(uploadPostProvider(context).notifier)
                          .uploadPostState(postData);
                    } else if (logoImage == null) {
                      setState(() {
                        imageValidationError =
                        'Please Upload A Logo Image';
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.themeColor1,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
              ref.watch(uploadPostProvider(context)).when(
                  data: (data) => Container(),
                  error: (error, st) => Text(
                    error.toString(),
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  loading: () =>
                      SpinKitRing(color: ColorsManager.themeColor1!))
            ],
          ),
        ),
      ),
   //   drawer: HomeDrawer(),
    );
  }
}
