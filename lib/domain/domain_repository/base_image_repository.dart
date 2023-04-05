import 'package:dartz/dartz.dart';

import 'package:stylebusters/core/exception_handling/failures.dart';
import 'package:stylebusters/core/exception_handling/success.dart';
import 'package:stylebusters/domain/entities/logo_entity.dart';

abstract class BaseUserRepository {

  Future<Either<Failure, Success>> getSimilarLogos(Map<String, String> updatedData, String userToken);

}
