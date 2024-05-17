import 'package:shoppy/core/utils/typedef.dart';
import 'package:shoppy/domain/entity/customer.dart';
import 'package:shoppy/domain/entity/order.dart';


abstract class Repository {
  Result<ProductList> fetchProducts();
  Result<CustomerList> fetchCustomers();
  Result<CustomerList> searchCustomers(String searchText);
  Result<OrderResult> createOrder({
    required Customer customer,
    required double totalAmount,
    required ProductList products
  });
}
