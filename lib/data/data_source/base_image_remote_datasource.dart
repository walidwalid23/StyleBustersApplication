import 'package:stylebusters/domain/entities/logo_entity.dart';
abstract class BaseImageRemoteDataSource {
  Future<String> getSimilarLogos(Logo logo);

}
