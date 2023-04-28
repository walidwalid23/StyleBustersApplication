import 'package:dartz/dartz.dart';
import 'package:stylebusters/core/exception_handling/failures.dart';
import 'package:stylebusters/domain/domain_repository/base_image_repository.dart';
import 'package:stylebusters/domain/entities/clothes_entity.dart';

class GetSimilarStyleClothes{
  BaseImageRepository imageRepository;
  GetSimilarStyleClothes({required this.imageRepository});

  Future<Either<Failure, List<RetrievedClothes>>> excute(UploadedClothes clothes, int pageNumber) async {
    return await imageRepository.getSimilarStyleClothes(clothes, pageNumber);

  }

}