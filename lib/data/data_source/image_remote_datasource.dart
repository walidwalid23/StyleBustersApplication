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
  Future<String> getSimilarLogos(Logo logo) async{
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
    });

    Dio dio = Dio();
    var response = await dio.post("${ServerManager.baseUrl}/sendLogo",
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
    if ((e.type == DioErrorType.connectionTimeout||
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
          print(st);
    // CATCH ANY OTHER LEFT EXCEPTION
    throw GenericException(errorMessage: "Unknown Exception Has Occurred");
    }
  }

}
