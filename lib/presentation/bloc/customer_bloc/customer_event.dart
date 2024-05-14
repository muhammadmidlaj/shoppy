part of 'customer_bloc.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object> get props => [];
}

class CustomerFetchEvent extends CustomerEvent {
  const CustomerFetchEvent();
}

class CustomerSelectEvent extends CustomerEvent {
  final Customer customer;

  const CustomerSelectEvent(this.customer);

  @override
  List<Object> get props =>
      [customer.id, customer.email, customer.mobileNumber];
}
