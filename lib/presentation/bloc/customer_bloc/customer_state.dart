part of 'customer_bloc.dart';

abstract class    CustomerState extends Equatable {
  CustomerState({List<Customer>? customerList, this.selectedCustomer})
      : customerList = customerList ?? [];
  final List<Customer> customerList;
  final Customer? selectedCustomer;
  @override
  List<Object> get props => [customerList];
}

class CustomerInitialState extends CustomerState {}

class CustomerLoadingState extends CustomerState {}

class CustomerLoadedState extends CustomerState {
  CustomerLoadedState({required List<Customer> customers})
      : super(customerList: customers);

  @override
  List<Object> get props => [customerList];
}

class CustomerFailureState extends CustomerState {
  final String message;

  CustomerFailureState(this.message);
  @override
  List<Object> get props => [message];
}

class CustomerSelectedState extends CustomerState {
  CustomerSelectedState(
      {required List<Customer> customerList,
      required Customer selectedCustomer})
      : super(customerList: customerList, selectedCustomer: selectedCustomer);
  @override
  List<Object> get props => [selectedCustomer!.id, customerList];
}
