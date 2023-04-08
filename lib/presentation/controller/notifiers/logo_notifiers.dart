import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:stylebusters/core/exception_handling/failures.dart';
import 'package:stylebusters/core/exception_handling/success.dart';
import 'package:stylebusters/data/data_source/base_image_remote_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:go_router/go_router.dart';
import '../../../data/data_repository/image_repository.dart';
import '../../../data/data_source/image_remote_datasource.dart';
import '../../../domain/domain_repository/base_image_repository.dart';
import '../../../domain/usecases/get_similar_logos_usecase.dart';
import '../../../domain/entities/logo_entity.dart';

class GetSimilarLogosStateNotifier extends StateNotifier <AsyncValue<dynamic>>{
  // the initial state will be null cause nothing should be shown till the sign up button is clicked
  GetSimilarLogosStateNotifier(): super( AsyncData(null) );

  void getSimilarLogosState(Logo logo, BuildContext context) async{

    BaseImageRemoteDataSource imageRemoteDataSource = ImageRemoteDataSource();
    BaseImageRepository imageRepository  = ImageRepository(imageRemoteDataSource);
    GetSimilarLogos getSimilarLogosUseCase = GetSimilarLogos(imageRepository: imageRepository);

    super.state = AsyncLoading();
    Either<Failure, Success> data = await getSimilarLogosUseCase.excute(logo);
    // USE .FOLD METHOD IN THE SCREENS LAYER TO DEAL WITH THE EITHER DATA
    data.fold((Failure failure) {
      super.state = AsyncError(failure.errorMessage, failure.stackTrace);
    } , (Success success) {
      //we don't need to change the state when succeed cause we will display toast
      // but we set it to null to stop loading in case the user went to previous screen
      super.state = AsyncData(null);

    var snackBar = SnackBar(
      content: Text(success.successMessage),
      duration: Duration(seconds: 8),
      backgroundColor: Colors.green,
      padding: EdgeInsets.all(30),


    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);


      /* Fluttertoast.showToast(
          msg:  success.successMessage,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb:10,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16,
      );
      */
    }



   );

  }
}
