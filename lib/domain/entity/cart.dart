import 'package:equatable/equatable.dart';
import 'package:shoppy/domain/entity/product.dart';

// ignore: must_be_immutable
class Cart extends Equatable {
  List<Product> cartItems;
  Cart(this.cartItems);

  @override
  List<Object?> get props => [cartItems];
}
