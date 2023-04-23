import 'package:dartz/dartz.dart';
import 'package:stylebusters/core/exception_handling/failures.dart';
import 'package:stylebusters/core/exception_handling/success.dart';
import 'package:stylebusters/domain/domain_repository/base_image_repository.dart';
import 'package:stylebusters/domain/entities/clothes_entity.dart';

class GetClothesLogos{
  BaseImageRepository imageRepository;
  GetClothesLogos({required this.imageRepository});

  Future<Either<Failure, Success>> excute(Clothes clothes) async {
    return await imageRepository.getSimilarClothes(clothes);
  }

}