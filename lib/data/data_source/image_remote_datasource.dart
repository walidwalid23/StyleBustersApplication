import 'package:dartz/dartz.dart';
import 'package:stylebusters/domain/entities/artwork_entity.dart';
import 'package:stylebusters/domain/entities/clothes_entity.dart';

import '../../domain/entities/logo_entity.dart';
import 'package:stylebusters/data/data_source/base_image_remote_datasource.dart';
import 'package:dio/dio.dart';
import '../../core/exception_handling/exceptions.dart';
import 'package:stylebusters/core/exception_handling/network_error_model.dart';
import '../../core/utils/constants/server_manager.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

class ImageRemoteDataSource extends BaseImageRemoteDataSource {
  @override
  Future<String> getSimilarLogos(Logo logo) async {
    // send a post request to the server
    try {
      File logoImage = logo.logoImage;
      String imageName = logoImage.path.split('/').last;
      String imageExtension = path.extension(logoImage.path).split('.').last;

      final imageFile = await MultipartFile.fromFile(
        logoImage.path,
        filename: imageName,
        contentType: MediaType("image", imageExtension), //important
      );

      FormData formData = FormData.fromMap({
        "image": imageFile,
        "email": logo.uploaderEmail,
        "country": logo.logosCountry
      });

      Dio dio = Dio();

      var response = await dio.post("${ServerManager.logosBaseUrl}/sendLogo",
          data: formData);

      int statusCode = response.statusCode!;

      if (statusCode == 200) {
        return response.data['successMessage'];
      }
      // since the server didn't return 200 then there must have been a problem
      else {
        throw ServerException(
            networkErrorModel: NetworkErrorModel.fromJson(response.data));
      }
    }
    // CATCHING THE DIO EXCEPTIONS AND THROWING OUR CUSTOM EXCEPTIONS
    on DioError catch (e) {
      if ((e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout)) {
        // handle no connection error
        throw ConnectionException(errorMessage: "No Internet Connection");
      }
      // this condition applies if status code falls out of the range of 2xx and is also not 304.
      //WE ALREADY HANDLED THIS ABOVE BUT WE MUST HANDLE IT THROW DIO AS WELL CAUSE IT THROWS IT
      else if (e.response != null) {
        //this is the same data as response.data
        print(e.response!.data);
        throw ServerException(
            networkErrorModel: NetworkErrorModel.fromJson(e.response!.data));
      } else {
        // rethrow the exception again cause you didn't handle it (nothing happens when its rethrown till you handle it)
        // rethrow;
        // OR CREATE A GENERIC ERROR MESSAGE
        throw GenericException(errorMessage: "Unknown Exception Has Occurred");
      }
    } catch (error, st) {
      print(error);
      print(st);
      // CATCH ANY OTHER LEFT EXCEPTION
      throw GenericException(errorMessage: "Unknown Exception Has Occurred");
    }
  }

  @override
  Future<String> getSimilarStyleArtworks(Artwork artwork) async {
    // send a post request to the server
    try {
      File artworkImage = artwork.artworkImage;
      String imageName = artworkImage.path.split('/').last;
      String imageExtension = path.extension(artworkImage.path).split('.').last;

      final imageFile = await MultipartFile.fromFile(
        artworkImage.path,
        filename: imageName,
        contentType: MediaType("image", imageExtension), //important
      );

      Dio dio = Dio();
      var response;

      if (artwork.artistNationality=='all'){
        FormData formData = FormData.fromMap({
          "image": imageFile,
          "email": artwork.uploaderEmail,
        });

        response = await dio.post(
            "${ServerManager.artworksBaseUrl}/get-all-artworks",
            data: formData);
      }
      else{
        String endPoint;
        if(artwork.forInspiration==true){
          endPoint = '/get-artworks-inspiration';
        }
        else{
          endPoint ='/get-artworks';
        }

        FormData formData = FormData.fromMap({
          "image": imageFile,
          "email": artwork.uploaderEmail,
          "artistNationality": artwork.artistNationality,
          "material": artwork.material,
          "timePeriod": artwork.timePeriod
        });
        response = await dio.post(
            "${ServerManager.artworksBaseUrl}"+endPoint,
            data: formData);
      }


      print(response.data);

      int statusCode = response.statusCode!;

      if (statusCode == 200) {
        return response.data['successMessage'];
      }
      // since the server didn't return 200 then there must have been a problem
      else {
        throw ServerException(
            networkErrorModel: NetworkErrorModel.fromJson(response.data));
      }
    }
    // CATCHING THE DIO EXCEPTIONS AND THROWING OUR CUSTOM EXCEPTIONS
    on DioError catch (e) {
      print(e);
      if ((e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout)) {
        // handle no connection error
        throw ConnectionException(errorMessage: "No Internet Connection");
      }
      // this condition applies if status code falls out of the range of 2xx and is also not 304.
      //WE ALREADY HANDLED THIS ABOVE BUT WE MUST HANDLE IT THROW DIO AS WELL CAUSE IT THROWS IT
      else if (e.response != null) {
        //this is the same data as response.data
        print(e.response!.data);
        throw ServerException(
            networkErrorModel: NetworkErrorModel.fromJson(e.response!.data));
      } else {
        // rethrow the exception again cause you didn't handle it (nothing happens when its rethrown till you handle it)
        // rethrow;
        // OR CREATE A GENERIC ERROR MESSAGE
        throw GenericException(errorMessage: "Unknown Exception Has Occurred");
      }
    } catch (error, st) {
      print(error);
      print(st);
      // CATCH ANY OTHER LEFT EXCEPTION
      throw GenericException(errorMessage: "Unknown Exception Has Occurred");
    }
  }

  @override
  Future<Either<List<RetrievedClothes>,List<String>>> getSimilarStyleClothes(UploadedClothes clothes, int pageNumber) async{
    // send a post request to the server
    try {
      File clothesImage = clothes.clothesImage;
      String imageName = clothesImage.path.split('/').last;
      String imageExtension = path.extension(clothesImage.path).split('.').last;
      String gender = clothes.gender;
      String? className = clothes.className;



      final imageFile = await MultipartFile.fromFile(
        clothesImage.path,
        filename: imageName,
        contentType: MediaType("image", imageExtension), //important
      );

      Dio dio = Dio();
      var response;

        FormData formData = FormData.fromMap({
          "image": imageFile,
          "gender": gender,
          "page": pageNumber,
          "className":className
        });
        response = await dio.post(
            "${ServerManager.clothesBaseUrl}/get-similar-clothes",
            data: formData);

      print(response.data);


      int statusCode = response.statusCode!;

      if (statusCode == 200) {
        // return the retrieved clothes on success
        if (response.data['results']!=null) {
          List jsonClothes = response.data['results'];
          List<RetrievedClothes> retrievedClothes = jsonClothes.map((
              clothesMap) =>
              RetrievedClothes(
                  imageURL: clothesMap["imageURL"],
                  productName: clothesMap["productName"],
                  productPrice: clothesMap["productPrice"],
                  productURL: clothesMap["productURL"])).toList();
          return Left(retrievedClothes);
        }
        else if (response.data['classes']!=null){
          List<String> classes = (response.data['classes'] as List).map((item) => item as String).toList();
          return Right(classes);
        }
        else {
          throw  response.data['errorMessage'];
        }
      }
      // since the server didn't return 200 then there must have been a problem
      else {
        throw ServerException(
            networkErrorModel: NetworkErrorModel.fromJson(response.data));
      }
    }
    // CATCHING THE DIO EXCEPTIONS AND THROWING OUR CUSTOM EXCEPTIONS
    on DioError catch (e) {
      print(e);
      if ((e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout)) {
        // handle no connection error
        throw ConnectionException(errorMessage: "No Internet Connection");
      }
      // this condition applies if status code falls out of the range of 2xx and is also not 304.
      //WE ALREADY HANDLED THIS ABOVE BUT WE MUST HANDLE IT THROW DIO AS WELL CAUSE IT THROWS IT
      else if (e.response != null) {
        //this is the same data as response.data
        print(e.response!.data);
        throw ServerException(
            networkErrorModel: NetworkErrorModel.fromJson(e.response!.data));
      } else {
        // rethrow the exception again cause you didn't handle it (nothing happens when its rethrown till you handle it)
        // rethrow;
        // OR CREATE A GENERIC ERROR MESSAGE
        throw GenericException(errorMessage: "Unknown Exception Has Occurred");
      }
    } catch (err, st) {
        print(err);
        print(st);
      // CATCH ANY OTHER LEFT EXCEPTION
      throw GenericException(errorMessage:err.toString() );
    }
  }


}
