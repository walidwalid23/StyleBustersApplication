import 'package:dartz/dartz.dart';
import 'package:stylebusters/core/exception_handling/failures.dart';
import 'package:stylebusters/core/exception_handling/success.dart';
import 'package:stylebusters/domain/entities/logo_entity.dart';
import 'package:stylebusters/domain/entities/artwork_entity.dart';

abstract class BaseImageRepository {

  Future<Either<Failure, Success>> getSimilarLogos(Logo logo);
  Future<Either<Failure, Success>> getSimilarStyleArtworks(Artwork artwork);

}
