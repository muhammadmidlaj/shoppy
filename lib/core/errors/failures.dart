abstract class Failure {
  final String message;

  Failure({required this.message});

}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
  
}

class InterNetFailure extends Failure {
  InterNetFailure({required super.message});
  
}
