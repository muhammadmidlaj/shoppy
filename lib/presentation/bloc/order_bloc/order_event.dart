part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderCreateEvent extends OrderEvent {
  final Customer customer;
  final double totalAmount;
  final List<Product> products;

  const OrderCreateEvent({required this.customer, required this.totalAmount, required this.products});

@override
  List<Object> get props => [customer,totalAmount,products];
}
