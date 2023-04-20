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
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../controller/providers/logos_providers.dart';
import 'package:email_validator/email_validator.dart';
import 'package:country_state_city/country_state_city.dart';

import '../reusable_widgets/home_drawer.dart';

class LogosScreen extends ConsumerStatefulWidget {
  const LogosScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LogosScreen> createState() => _LogosScreenState();
}

class _LogosScreenState extends ConsumerState<LogosScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? logoImage;
  String imageValidationError = '';
  TextEditingController emailController = TextEditingController();
  String dropdownValue = "select";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Similar Logos'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/logo.jpg'),
                  fit: BoxFit.cover)),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                CustomTextInputField(
                  hintText: "Enter Your Email",
                  label: const Text("Email*"),
                  validatorFunc: (value) {
                    if (value == null || value.isEmpty) {
                      return 'You Cannot Leave The Email Field Empty';
                    } else if (EmailValidator.validate(value) == false) {
                      return 'Please Enter A Valid Email';
                    } else if (value.length > 60) {
                      return 'Exceeded Maximum Characters Length';
                    }
                    return null;
                  },
                  textFieldController: emailController,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: FutureBuilder(
                      future: getAllCountries(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          // load all countries
                          return DropdownButtonFormField(
                            value: dropdownValue,
                            items: [
                                  DropdownMenuItem<String>(
                                    value: "select",
                                    child: Text("Select Country",
                                        style: TextStyle(color: Colors.grey)),
                                    enabled: false,
                                  )
                                ] +
                                snapshot.data
                                    .map<DropdownMenuItem<String>>(
                                        (country) => DropdownMenuItem<String>(
                                              value: country.isoCode,
                                              child: Text(country.name,
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ))
                                    .toList(),
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
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10))),
                          );
                        } else {
                          return SpinKitRing(color: ColorsManager.themeColor1!);
                        }
                      }),
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
                        Logo logo = Logo(
                            uploaderEmail: emailController.text,
                            logoImage: logoImage!,
                            logosCountry: dropdownValue);
                        // upload the post
                        ref
                            .read(getSimilarLogosProvider.notifier)
                            .getSimilarLogosState(logo, context);
                      } else if (logoImage == null) {
                        setState(() {
                          imageValidationError = 'Please Upload A Logo Image';
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
                ref.watch(getSimilarLogosProvider).when(
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
      ),
      drawer: const HomeDrawer(),
    );
  }
}
