import 'package:dartz/dartz.dart';
import 'package:shoppy/core/errors/error.dart';
import 'package:shoppy/domain/entity/customer.dart';
import 'package:shoppy/domain/entity/product.dart';

typedef DataMap = Map<String, dynamic>;
typedef Result<T> = Future<Either<Failure, T>>;
typedef ProductList = List<Product>;
typedef CustomerList = List<Customer>;

