import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:stylebusters/core/exception_handling/failures.dart';
import 'package:stylebusters/core/exception_handling/success.dart';
import 'package:stylebusters/data/data_source/base_image_remote_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stylebusters/domain/entities/clothes_entity.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:go_router/go_router.dart';
import '../../../data/data_repository/image_repository.dart';
import '../../../data/data_source/image_remote_datasource.dart';
import '../../../domain/domain_repository/base_image_repository.dart';
import '../../../domain/usecases/get_similar_artworks_usecase.dart';
import '../../../domain/entities/artwork_entity.dart';
import '../../../domain/usecases/get_similar_clothes_usecase.dart';

class GetSimilarStyleClothesStateNotifier extends StateNotifier <AsyncValue<dynamic>>{
  // the initial state will be null cause nothing should be shown till the sign up button is clicked
  GetSimilarStyleClothesStateNotifier(): super( AsyncData(null) );

  void getSimilarClothesState(UploadedClothes clothes,int pageNumber ,BuildContext context) async{

    BaseImageRemoteDataSource imageRemoteDataSource = ImageRemoteDataSource();
    BaseImageRepository imageRepository  = ImageRepository(imageRemoteDataSource);
    GetSimilarStyleClothes getSimilarStyleClothesUseCase = GetSimilarStyleClothes(imageRepository:imageRepository);

    super.state = AsyncLoading();
    Either<Failure, List<RetrievedClothes>> data = await getSimilarStyleClothesUseCase.excute(clothes,pageNumber);
    // USE .FOLD METHOD IN THE SCREENS LAYER TO DEAL WITH THE EITHER DATA
    data.fold((Failure failure) {
      super.state = AsyncError(failure.errorMessage, failure.stackTrace);
    } , (List<RetrievedClothes> retrievedClothes) {
      print("data received");
      print(retrievedClothes);
      super.state = AsyncData(retrievedClothes);

      // close the bottomsheet
      Navigator.pop(context);



    }



    );

  }


}
