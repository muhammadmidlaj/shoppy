import 'package:shoppy/core/utils/typedef.dart';
import 'package:shoppy/domain/entity/customer.dart';
import 'package:shoppy/domain/entity/product.dart';

abstract class Repository {
  Result<List<Product>> fetchProducts();
  Result<List<Customer>> fetchCustomers();
}
