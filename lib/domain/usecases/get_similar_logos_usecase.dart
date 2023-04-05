import '../../core/exception_handling/failures.dart';
import 'package:stylebusters/core/exception_handling/success.dart';
import '../domain_repository/base_image_repository.dart';
import 'package:dartz/dartz.dart';
import '../entities/logo_entity.dart';

class GetSimilarLogos{
  BaseImageRepository imageRepository;
  GetSimilarLogos({required this.imageRepository});

  Future<Either<Failure, Success>> excute(Logo logo) async {
    return await imageRepository.getSimilarLogos(logo);

  }

}