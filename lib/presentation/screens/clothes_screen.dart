import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylebusters/core/utils/constants/colors_manager.dart';
import 'package:stylebusters/domain/entities/clothes_entity.dart';
import 'package:stylebusters/presentation/reusable_widgets/DefaultFormField.dart';
import 'package:stylebusters/presentation/reusable_widgets/show_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/constants/styles_manager.dart';
import '../controller/providers/clothes_providers.dart';
import '../reusable_widgets/home_drawer.dart';
import '../reusable_widgets/image_container.dart';

class ClothesScreen extends ConsumerStatefulWidget {
  const  ClothesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ClothesScreen> createState() => _ClothesScreenState();
}


class _ClothesScreenState extends ConsumerState<ClothesScreen> {
   final ImagePicker _picker = ImagePicker();
   File? clothesImage;
   String imageValidationError = '';
   var formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
              "Find Similar Clothes",
          ),
        centerTitle: true,
        ),
      body: ref.watch(getSimilarStyleClothesProvider).when(
          data: (retrievedClothesList) => (retrievedClothesList==null)?Center(child:Text(
              "Start Uploading Clothes",style: TextStyle(fontWeight:FontWeight.bold,
          fontSize: 25),)):SingleChildScrollView(
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
                  itemCount: retrievedClothesList.length,
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
                              imageUrl: retrievedClothesList[index].imageURL,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  retrievedClothesList[index].productName,
                                  style: Theme.of(context).textTheme.titleMedium!.merge(
                                    const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  retrievedClothesList[index].productPrice,
                                  style: Theme.of(context).textTheme.titleMedium!.merge(
                                    TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
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
                  height: 20,
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
          error: (error, st) => Text(
            error.toString(),
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold),
          ),
          loading: () =>
              SpinKitRing(color: ColorsManager.themeColor1!))
      ,


          floatingActionButton: FloatingActionButton(
                onPressed: (){
                    showModalBottomSheet(
                            context:context,
                            builder:(context) => StatefulBuilder(
                                builder:(context,setState)=> Form(
                    key: formKey,
                    child: ListView(
                      children: [
                        ImageContainer(
                          uploadedImage: clothesImage,
                          width: 200,
                          height: 200,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: ElevatedButton(
                              child: const Text('Upload Clothes Image'),
                              onPressed: () async {
                                final XFile? image =
                                await _picker.pickImage(source: ImageSource.gallery);
                                if (image == null) {
                                  return;
                                }
                                setState(() {
                                  clothesImage = File(image.path);
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
                                if (formKey.currentState!.validate() &&
                                    clothesImage != null) {
                                  // DATA IS VALID
                                  UploadedClothes uploadedClothes = UploadedClothes(
                                 clothesImage: clothesImage,
                                    gender: "Male"
                                  );
                                  // upload the post
                                  ref.read(getSimilarStyleClothesProvider.notifier).getSimilarClothesState(uploadedClothes,1,context);
                                  // reubuild the bottom sheet manually to be able to watch the provider
                                  setState((){});
                                } else if (clothesImage == null) {
                                  setState(() {
                                    imageValidationError =
                                    'Please Upload A Clothes Image';
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
                        ref.watch(getSimilarStyleClothesProvider).when(
                              data: (data) => Container(),
                              error: (error, st) => Text(
                                error.toString(),
                                style: TextStyle(
                                    color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                              loading: () {
                                   print("in loading");
                                  return SpinKitRing(color: ColorsManager.themeColor1!);}
                        )
                      ],
                    ),
                  ),
                            ));

              },
              child:Icon(
                  Icons.add
              ),
            ),
            drawer: const HomeDrawer(),
    );
  }
}
