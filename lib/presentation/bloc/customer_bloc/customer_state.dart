part of 'customer_bloc.dart';

abstract class CustomerState extends Equatable {
  CustomerState({List<Customer>? customerList, Customer? customer})
      : customerList = customerList ?? [],
        selectedCustomer = customer ?? Customer.empty();
  final List<Customer> customerList;
  final Customer selectedCustomer;
  @override
  List<Object> get props => [customerList];
}

class CustomerInitialState extends CustomerState {}

class CustomerLoadingState extends CustomerState {}

class CustomerLoadedState extends CustomerState {
  CustomerLoadedState({required List<Customer> customers})
      : super(
          customerList: customers,
        );

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
      : super(customerList: customerList, customer: selectedCustomer);
  @override
  List<Object> get props => [selectedCustomer.id, customerList];
}

class CustomerSelectionClearedState extends CustomerState {
  CustomerSelectionClearedState(
      {required List<Customer> customerList,
      required Customer selectedCustomer})
      : super(customerList: customerList, customer: selectedCustomer);
  @override
  List<Object> get props => [selectedCustomer.id, customerList];
}


