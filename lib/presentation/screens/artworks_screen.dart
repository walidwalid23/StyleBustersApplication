import 'package:stylebusters/core/utils/constants/colors_manager.dart';
import 'package:stylebusters/core/utils/constants/styles_manager.dart';
import 'package:stylebusters/presentation/reusable_widgets/custom_input_form_field.dart';
import 'package:stylebusters/presentation/reusable_widgets/image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../domain/entities/artwork_entity.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../controller/providers/artworks_providers.dart';
import 'package:email_validator/email_validator.dart';
import '../reusable_widgets/home_drawer.dart';


class ArtworksScreen extends ConsumerStatefulWidget {
  const  ArtworksScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ArtworksScreen> createState() => _ArtworksScreenState();
}

class _ArtworksScreenState extends ConsumerState<ArtworksScreen> {

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? artworkImage;
  String imageValidationError = '';
  TextEditingController emailController = TextEditingController();
  String artistNationalityDropdownValue = "select";
  String materialDropdownValue = "select";
  String timePeriodDropdownValue = "select";
  int dropDownChoicesCounter = 0;

  List<String> artistsNationalities=['American', 'Angolan', 'Argentine', 'Armenian', 'Australian'
    , 'Austrian', 'Belarusian', 'Belgian', 'Beninese', 'Brazilian', 'British', 'Bulgarian', 'Burmese',
    'Cameroonian', 'Canadian', 'Catalan', 'Chilean', 'Chinese', 'Chinese-American', 'Colombian',
    'Congolese', 'Croatian', 'Cuban', 'Czech', 'Danish', 'Dominican', 'Dutch', 'Ecuadorian',
    'Egyptian', 'English', 'Finnish', 'French', 'French-Canadian', 'Georgian', 'German', 'Ghanaian',
    'Greek', 'Haitian', 'Hong Kong', 'Hungarian', 'Icelandic', 'Indian', 'Indonesian', 'Iranian', 'Iraqi',
    'Irish', 'Israeli', 'Italian', 'Ivorian', 'Jamaican', 'Japanese', 'Japanese-American', 'Jordanian', 'Kenyan',
    'Korean', 'Latvian', 'Lebanese', 'Lithuanian', 'Malaysian', 'Mexican', 'Moroccan', 'Mozambican', 'Netherlandish',
    'New Zealand', 'Nigerian', 'Norwegian', 'Pakistani', 'Palestinian', 'Peruvian', 'Philippine', 'Polish', 'Portuguese',
    'Puerto Rican', 'Romanian', 'Russian', 'Russian-American', 'Scottish', 'Senegalese', 'Serbian', 'Singaporean', 'Slovak',
    'Slovene', 'South African', 'South Korean', 'Spanish', 'Sudanese', 'Swedish', 'Swiss', 'Syrian', 'Taiwanese', 'Thai',
    'Turkish', 'Ugandan', 'Ukrainian', 'Uruguayan', 'Venezuelan', 'Vietnamese', 'Welsh', 'Zimbabwean', 'Other'];

  List<String> materials = ['acrylic', 'aluminum', 'aquatint', 'Arches paper', 'art paper', 'blown glass'
    , 'brass', 'bronze', 'c-print', 'canvas', 'cardboard', 'ceramic', 'chalk', 'charcoal', 'clay', 'collage', 'concrete'
    , 'copper', 'cotton', 'crystal', 'digital', 'drypoint', 'dye', 'earthenware', 'embroidery', 'enamel',
    'engraving', 'epoxy', 'etching', 'foam', 'giclée', 'glass', 'glaze', 'gold', 'gouache', 'graphite', 'ink', 'inkjet print',
    'iron', 'lacquer', 'laid paper', 'leaf', 'leather', 'linen', 'linocut', 'lithograph', 'mahogany', 'marble',
    'metal', 'mixed media', 'monoprint', 'monotype', 'oak', 'oil', 'paint', 'panel', 'paper', 'pastel', 'patina',
    'pencil', 'pigment', 'plaster', 'plastic', 'platinum', 'plexiglass', 'polaroid', 'polyurethane', 'porcelain',
    'powder', 'rag paper', 'resin', 'screen print', 'silk', 'silver', 'silver gelatin', 'sound', 'spray paint',
    'stainless steel', 'steel', 'stone', 'stoneware', 'teak', 'thread', 'upholstery', 'video', 'vinyl',
    'walnut', 'wash', 'watercolor', 'wire', 'wood', 'woodcut', 'wool', 'wove paper',];

  List<String> timePeriods = ['Mid%2019th Century', 'Late%2019th Century', 'Early%2019th Century', '2020', '2010', '2000',
    '1990','1980', '1970', '1960','1950', '1940', '1930','1920', '1910', '1900','18th Century & Earlier' ];



  @override
  Widget build(BuildContext context) {
    print(materials.length);
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Similar Style Artworks'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/artworks-bg.jpg'),
                  alignment: Alignment.center,
                  opacity: 1,

                  scale: 1,
                  fit: BoxFit.cover,)),
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
                    } else if(EmailValidator.validate(value)==false){
                      return 'Please Enter A Valid Email';

                    } else if (value.length > 60) {
                      return 'Exceeded Maximum Characters Length';
                    }
                    return null;
                  },
                  textFieldController: emailController ,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: DropdownButtonFormField(
                            value: artistNationalityDropdownValue,
                            items:[DropdownMenuItem<String>(
                              value: "select",
                              child: Text("Select Artist Nationality",
                                  style: TextStyle(color: Colors.grey)),
                              enabled: false,
                            ),
                              DropdownMenuItem<String>(
                                value: "all",
                                child: Text("All Artists",
                                    style: TextStyle(color: Colors.black)),
                              )

                            ]+artistsNationalities.map((artistNationality) =>
                                DropdownMenuItem<String>(
                                  value: artistNationality ,
                                  child: Text(artistNationality,
                                      style: TextStyle(color: Colors.black)),

                                )).toList()
                            ,onChanged: (value) {
                            setState(() {
                              artistNationalityDropdownValue = value!;
                              if(value!='select'){
                                dropDownChoicesCounter+=1;
                              }
                            });
                          },

                            validator: (value) {
                              if ((value == null || value == 'select') && dropDownChoicesCounter==0) {
                                return 'Please Select One Choice';
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
                                    borderRadius: BorderRadius.circular(10))
                            ),
                          )
                ),
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: DropdownButtonFormField(
                      value: materialDropdownValue,
                      items:[DropdownMenuItem<String>(
                        value: "select",
                        child: Text("Select Material",
                            style: TextStyle(color: Colors.grey)),
                        enabled: false,
                      )
                      ]+materials.map((material) =>
                          DropdownMenuItem<String>(
                            value: material ,
                            child: Text(material,
                                style: TextStyle(color: Colors.black)),

                          )).toList()
                      ,onChanged: (value) {
                      setState(() {
                        materialDropdownValue = value!;
                        if(value!='select'){
                          dropDownChoicesCounter+=1;
                        }
                      });
                    },

                      validator: (value) {
                        if ((value == null || value == 'select') && dropDownChoicesCounter==0) {
                          return 'Please Select One Choice';
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
                              borderRadius: BorderRadius.circular(10))
                      ),
                    )
                ),
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: DropdownButtonFormField(
                      value: timePeriodDropdownValue,
                      items:[DropdownMenuItem<String>(
                        value: "select",
                        child: Text("Select Time Period",
                            style: TextStyle(color: Colors.grey)),
                        enabled: false,
                      )
                      ]+timePeriods.map((timePeriod) =>
                          DropdownMenuItem<String>(
                            value: timePeriod ,
                            child: Text(timePeriod.replaceAll('%',' '),
                                style: TextStyle(color: Colors.black)),

                          )).toList()
                      ,onChanged: (value) {
                      setState(() {
                        timePeriodDropdownValue = value!;
                        if(value!='select'){
                          dropDownChoicesCounter+=1;
                        }
                      });
                    },

                      validator: (value) {
                        if ((value == null || value == 'select') && dropDownChoicesCounter==0) {
                          return 'Please Select One Choice';
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
                              borderRadius: BorderRadius.circular(10))
                      ),
                    )
                )
                ,ImageContainer(
                  uploadedImage: artworkImage,
                  width: 200,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    child: const Text('Upload Artwork Image'),
                    onPressed: () async {
                      final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                      if (image == null) {
                        return;
                      }
                      setState(() {
                        artworkImage = File(image.path);
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
                      'Submit For Stealing Check',
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          artworkImage != null) {
                        // DATA IS VALID
                        Artwork artwork = Artwork(
                            uploaderEmail: emailController.text,
                            artworkImage: artworkImage!,
                            artistNationality: (artistNationalityDropdownValue=='select')?null:artistNationalityDropdownValue,
                            material: (materialDropdownValue=='select')?null:materialDropdownValue,
                            timePeriod: (timePeriodDropdownValue=='select')?null:timePeriodDropdownValue
                        );
                        // upload the post
                        ref.read(getSimilarStyleArtworksProvider.notifier).getSimilarArtworksState(artwork,context);
                      } else if (artworkImage == null) {
                        setState(() {
                          imageValidationError =
                          'Please Upload Artwork Image';
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
              Center(child:Container(color:Colors.white,child: Text("OR",style: TextStyle(fontSize:30,
              fontWeight: FontWeight.bold),)))
              ,
                Padding(
                  padding: const EdgeInsets.only(left: 80, right: 80),
                  child: ElevatedButton(
                    child: Text(
                      'Submit For Inspiration Check',
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          artworkImage != null) {
                        // DATA IS VALID
                        Artwork artwork = Artwork(
                            uploaderEmail: emailController.text,
                            artworkImage: artworkImage!,
                            artistNationality: (artistNationalityDropdownValue=='select')?null:artistNationalityDropdownValue,
                            material: (materialDropdownValue=='select')?null:materialDropdownValue,
                            timePeriod: (timePeriodDropdownValue=='select')?null:timePeriodDropdownValue,
                            forInspiration: true
                        );
                        // upload the post
                        ref.read(getSimilarStyleArtworksProvider.notifier).getSimilarArtworksState(artwork,context);
                      } else if (artworkImage == null) {
                        setState(() {
                          imageValidationError =
                          'Please Upload Artwork Image';
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
                )
                ,
                ref.watch(getSimilarStyleArtworksProvider).when(
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
