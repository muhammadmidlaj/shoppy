import 'package:dartz/dartz.dart';
import 'package:shoppy/core/errors/error.dart';

typedef DataMap = Map<String, dynamic>;
typedef Result<T> = Future<Either<Failure,T>> ;
