import 'package:stylebusters/domain/entities/clothes_entity.dart';
import 'package:stylebusters/domain/entities/logo_entity.dart';
import 'package:stylebusters/domain/entities/artwork_entity.dart';

abstract class BaseImageRemoteDataSource {
  Future<String> getSimilarLogos(Logo logo);
  Future<String> getSimilarStyleArtworks(Artwork artwork);
  Future<List<RetrievedClothes>> getSimilarStyleClothes(UploadedClothes clothes, int pageNumber);
}
