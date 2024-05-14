part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddProductToCartEvent extends CartEvent {
  final Product product;

  const AddProductToCartEvent(this.product);
  @override
  List<Object> get props => [product];
}

class RemoveProductFromCartEvent extends CartEvent {
  final Product product;

  const RemoveProductFromCartEvent(this.product);
  @override
  List<Object> get props => [product];
}

class CartProductIncrementEvent extends CartEvent {
  final Product product;

  const CartProductIncrementEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class CartProductDecrementEvent extends CartEvent {
  final Product product;

  const CartProductDecrementEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class AddCustomerTocartEvent extends CartEvent {
  final Customer customer;

  const AddCustomerTocartEvent({required this.customer});

  @override
  List<Object> get props => [customer];
}
