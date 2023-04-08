import 'package:dartz/dartz.dart';
import 'package:stylebusters/core/exception_handling/failures.dart';
import 'package:stylebusters/core/exception_handling/success.dart';
import 'package:stylebusters/domain/entities/artwork_entity.dart';
import 'package:stylebusters/domain/entities/logo_entity.dart';
import '../../core/exception_handling/exceptions.dart';
import '../../domain/domain_repository/base_image_repository.dart';
import '../data_source/base_image_remote_datasource.dart';


class ImageRepository extends BaseImageRepository {
  BaseImageRemoteDataSource imageRemoteDataSource;

  ImageRepository(this.imageRemoteDataSource);

  @override
  Future<Either<Failure, Success>> getSimilarLogos(Logo logo) async {
    try {
      String uploadedLogoSuccessMsg = await imageRemoteDataSource.getSimilarLogos(logo);
      //if no exception was thrown then the method has succeeded
      return Right(ServerSuccess(successMessage: uploadedLogoSuccessMsg));
    } on ConnectionException catch (exception, stackTrace) {
      return Left(ConnectionFailure(
          errorMessage: exception.errorMessage, stackTrace: stackTrace));
    } on ServerException catch (exception, stackTrace) {
      return Left(ServerFailure(
          errorMessage: exception.networkErrorModel.errorMessage,
          stackTrace: stackTrace));
    } on GenericException catch (exception, stackTrace) {
      return Left(GenericFailure(
          errorMessage: exception.errorMessage, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, Success>> getSimilarStyleArtworks(Artwork artwork) async{
    try {
      String uploadedArtworkSuccessMsg = await imageRemoteDataSource.getSimilarStyleArtworks(artwork);
      //if no exception was thrown then the method has succeeded
      return Right(ServerSuccess(successMessage: uploadedArtworkSuccessMsg));
    } on ConnectionException catch (exception, stackTrace) {
      return Left(ConnectionFailure(
          errorMessage: exception.errorMessage, stackTrace: stackTrace));
    } on ServerException catch (exception, stackTrace) {
      return Left(ServerFailure(
          errorMessage: exception.networkErrorModel.errorMessage,
          stackTrace: stackTrace));
    } on GenericException catch (exception, stackTrace) {
      return Left(GenericFailure(
          errorMessage: exception.errorMessage, stackTrace: stackTrace));
    }
          
  }
}