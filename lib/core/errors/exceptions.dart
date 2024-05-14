import 'package:equatable/equatable.dart';

class ServerException implements Exception {
  final int code;
  final String message;

  ServerException({required this.code, required this.message});
}

class DataParsingException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

class NoConnectionException extends Equatable implements Exception {
  final String message = "Oops! It seems you're offline. Please check your internet connection";
  @override
  List<Object?> get props => [message];
}
