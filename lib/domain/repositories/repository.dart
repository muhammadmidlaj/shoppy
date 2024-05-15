import 'package:shoppy/core/utils/typedef.dart';
import 'package:shoppy/domain/entity/customer.dart';
import 'package:shoppy/domain/entity/order.dart';
import 'package:shoppy/domain/entity/product.dart';

abstract class Repository {
  Result<List<Product>> fetchProducts();
  Result<List<Customer>> fetchCustomers();
  Result<List<Customer>> searchCustomers(String searchText);
  Result<OrderResult> createOrder({
    required Customer customer,
    required double totalAmount,
    required List<Product> products
  });
}
