import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:stylebusters/core/exception_handling/failures.dart';
import 'package:stylebusters/data/data_source/base_image_remote_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stylebusters/domain/entities/clothes_entity.dart';
import '../../../data/data_repository/image_repository.dart';
import '../../../data/data_source/image_remote_datasource.dart';
import '../../../domain/domain_repository/base_image_repository.dart';
import '../../../domain/usecases/get_similar_clothes_usecase.dart';

class GetSimilarStyleClothesStateNotifier extends StateNotifier <AsyncValue<dynamic>>{
  // the initial state will be null cause nothing should be shown till the sign up button is clicked
  GetSimilarStyleClothesStateNotifier(initialState): super( initialState );

  void getSimilarClothesState(UploadedClothes clothes,int pageNumber ,BuildContext context) async{

    BaseImageRemoteDataSource imageRemoteDataSource = ImageRemoteDataSource();
    BaseImageRepository imageRepository  = ImageRepository(imageRemoteDataSource);
    GetSimilarStyleClothes getSimilarStyleClothesUseCase = GetSimilarStyleClothes(imageRepository:imageRepository);


    if (pageNumber == 1){ super.state = AsyncLoading();}
    else{
      // since this isn't the first page therefore the state already has a list of clothes
      state = AsyncData(state.value!.copyWith(newFetchingLoading:true));
    }

    Either<Failure, Either<List<RetrievedClothes>,List<String>>> data = await getSimilarStyleClothesUseCase.excute(clothes,pageNumber);
    // USE .FOLD METHOD IN THE SCREENS LAYER TO DEAL WITH THE EITHER DATA
    data.fold((Failure failure) {
      super.state = AsyncError(failure.errorMessage, failure.stackTrace);
    } , (Either<List<RetrievedClothes>,List<String>> clothesOrClasses) {
        clothesOrClasses.fold((List<RetrievedClothes> retrievedClothes) {
          if (state is AsyncLoading) {
            // initialize the state object again since it may have AsyncLoading state not the object
            super.state = AsyncData(ClothesPagination(fetchingLoading: false,
                retrievedClothes: retrievedClothes));
            // close the bottomsheet only here since this is the first page loaded from the floating action button
            // but the next data will be loaded from the main clothes screen so you shouldn't pop that screen
            if(clothes.className==null) {
              // cause when there are class name choices we will be on the main clothes screen not the bottom sheet
              Navigator.pop(context);
            }
          }
          else {
            print("data received");
            print(retrievedClothes);
            //SET THE FETCHLOADING TO FALSE SINCE DATA HAS FINISHED FETCHING
            print(state);
            state.value!.fetchingLoading = false;
            //add old posts + new posts
            state.value!.retrievedClothes.addAll(retrievedClothes);
            super.state = AsyncData(state.value!.copyWith(
                newClothes: state.value!.retrievedClothes
                , newFetchingLoading: state.value!.fetchingLoading));
          }



        }, (List<String> classes) {

          super.state = AsyncData( classes);
          Navigator.pop(context);

        });




    }



    );

  }


}
