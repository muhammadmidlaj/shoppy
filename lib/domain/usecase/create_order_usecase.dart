import 'package:shoppy/core/usecase/usecase.dart';
import 'package:shoppy/core/utils/typedef.dart';
import 'package:shoppy/domain/entity/customer.dart';
import 'package:shoppy/domain/entity/order.dart';
import 'package:shoppy/domain/entity/product.dart';
import 'package:shoppy/domain/repositories/repository.dart';

class CreateOrderUsecase implements UseCase<OrderResult, CreateOrderParams> {
  final Repository _repository;

  CreateOrderUsecase(this._repository);
  @override
  Result<OrderResult> call(CreateOrderParams params) async {
    return _repository.createOrder(
        customer: params.customer,
        totalAmount: params.totalAmount,
        products: params.products);
  }
}

class CreateOrderParams {
  final Customer customer;
  final double totalAmount;
  final List<Product> products;

  CreateOrderParams(
      {required this.customer,
      required this.totalAmount,
      required this.products});
}
