import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylebusters/core/utils/constants/colors_manager.dart';
import 'package:stylebusters/domain/entities/clothes_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/constants/styles_manager.dart';
import '../controller/providers/clothes_providers.dart';
import '../reusable_widgets/home_drawer.dart';
import '../reusable_widgets/image_container.dart';
import 'package:url_launcher/url_launcher.dart';

class ClothesScreen extends ConsumerStatefulWidget {
  const  ClothesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ClothesScreen> createState() => _ClothesScreenState();
}


class _ClothesScreenState extends ConsumerState<ClothesScreen> {
   final ImagePicker _picker = ImagePicker();
   File? clothesImage;
   String gender="Men";
   String imageValidationError = '';
   int pageNumber = 1;
   late UploadedClothes uploadedClothes;
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
          data: (clothesPagination) {
            return (clothesPagination.retrievedClothes.length==0)?Center(child:Text(
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
                  itemCount:clothesPagination.retrievedClothes.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: ()async{
                        try {
                          String url = clothesPagination.retrievedClothes[index].productURL;
                          print(url);
                          await launchUrl(Uri.parse(url));

                        }
                        catch(ex){
                          print(ex);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            16.0,
                          ),
                          color: Colors.orangeAccent,
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
                                imageUrl: clothesPagination.retrievedClothes[index].imageURL,
                              ),
                            ),
                            Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:EdgeInsets.all(6),
                                      child: Text(
                                        clothesPagination.retrievedClothes[index].productName,
                                        style: Theme.of(context).textTheme.titleSmall!.merge(
                                          const TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        maxLines: 3,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Center(
                                      child: Text(
                                        clothesPagination.retrievedClothes[index].productPrice,
                                        style: Theme.of(context).textTheme.titleMedium!.merge(
                                          TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),


                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                (ref.watch(getSimilarStyleClothesProvider).value!.fetchingLoading)?
                Center(child:SpinKitRing(color: ColorsManager.themeColor1!)):Container()
                ,
                ElevatedButton(
                  child: const Text('Load More'),
                  onPressed: () {
                    pageNumber += 1;
                    // get the new clothes with the new page number
                    ref.read(getSimilarStyleClothesProvider.notifier).getSimilarClothesState(uploadedClothes,pageNumber,context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.themeColor1
                  ),
                ),
              ],
            ),
          );},
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
                        isScrollControlled: true,
                            context:context,
                            builder:(context) => StatefulBuilder(
                                builder:(context,setState)=> Container(
                                  height: MediaQuery.of(context).size.height * 0.70,
                                  child: Form(
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

                          Center(child: Text("Select Gender: ",style:TextStyle(fontWeight:FontWeight.bold))),
                          ListTile(
                            title: const Text('Male'),
                            leading: Radio(
                              value: "Men",
                              groupValue:gender,
                              onChanged: (value) {

                                  setState(() {
                                    gender = value!;
                                  });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Female'),
                            leading: Radio(
                              value: "Women",
                              groupValue:gender,
                              onChanged: (value) {

                                  setState(() {
                                    gender = value!;
                                  });
                              },
                            ),
                          ),



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
                                   uploadedClothes = UploadedClothes(
                                   clothesImage: clothesImage,
                                      gender: gender
                                    );
                                    // upload the post
                                    ref.read(getSimilarStyleClothesProvider.notifier).getSimilarClothesState(uploadedClothes,pageNumber,context);
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

                                    return SpinKitRing(color: ColorsManager.themeColor1!);}
                        )
                      ],
                    ),
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
