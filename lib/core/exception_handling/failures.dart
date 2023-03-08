abstract class Failure{
  final String errorMessage;
  final StackTrace stackTrace;

  const Failure({required this.errorMessage, required this.stackTrace});
}


class ConnectionFailure extends Failure{
  ConnectionFailure({required super.errorMessage, required super.stackTrace});

}

class ServerFailure extends Failure{
  ServerFailure({required super.errorMessage, required super.stackTrace});

}

class LocalDatabaseFailure extends Failure{
  LocalDatabaseFailure({required super.errorMessage, required super.stackTrace});

}

class GenericFailure extends Failure{
  GenericFailure({required super.errorMessage, required super.stackTrace});

}
