part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderCreatedState extends OrderState {
  final OrderResult order;

  const OrderCreatedState({required this.order});
  @override
  List<Object> get props => [order];
}

class OrderFailureState extends OrderState {
  final String message;

  const OrderFailureState({required this.message});
@override
  List<Object> get props => [message];
  
}
