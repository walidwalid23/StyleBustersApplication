import 'network_error_model.dart';

class ServerException implements Exception{
  final NetworkErrorModel networkErrorModel;

  const ServerException({
    required this.networkErrorModel});
}

class ConnectionException implements Exception{
  final String errorMessage;

  ConnectionException({required this.errorMessage});

}

class LocalDatabaseException implements Exception{
  final String errorMessage;

  LocalDatabaseException({required this.errorMessage});

}

class GenericException implements Exception{
  final String errorMessage;

  GenericException({required this.errorMessage});

}