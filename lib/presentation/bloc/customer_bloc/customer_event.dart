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

class CustomerSelctionClearEvent extends CustomerEvent {
  const CustomerSelctionClearEvent();
  @override
  List<Object> get props => [];
}

class CustomerSearchEvent extends CustomerEvent {
  final String searchText;

  const CustomerSearchEvent({required this.searchText});
   @override
  List<Object> get props => [searchText];
}
