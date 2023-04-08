import '../../core/exception_handling/failures.dart';
import 'package:stylebusters/core/exception_handling/success.dart';
import '../domain_repository/base_image_repository.dart';
import 'package:dartz/dartz.dart';
import '../entities/artwork_entity.dart';

class GetSimilarStyleArtworks{
  BaseImageRepository imageRepository;
  GetSimilarStyleArtworks({required this.imageRepository});

  Future<Either<Failure, Success>> excute(Artwork artwork) async {
    return await imageRepository.getSimilarStyleArtworks(artwork);

  }

}