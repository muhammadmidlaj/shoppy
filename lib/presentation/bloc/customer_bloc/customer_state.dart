part of 'customer_bloc.dart';

abstract class CustomerState extends Equatable {
  CustomerState({CustomerList? customerList, Customer? customer})
      : customerList = customerList ?? [],
        selectedCustomer = customer ?? Customer.empty();
  final CustomerList customerList;
  final Customer selectedCustomer;
  @override
  List<Object> get props => [customerList];
}

class CustomerInitialState extends CustomerState {}

class CustomerLoadingState extends CustomerState {}

class CustomerLoadedState extends CustomerState {
  CustomerLoadedState({required CustomerList customers,required Customer selectedCustomer})
      : super(
          customerList: customers,
          customer: selectedCustomer
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
      {required CustomerList customerList,
      required Customer selectedCustomer})
      : super(customerList: customerList, customer: selectedCustomer);
  @override
  List<Object> get props => [selectedCustomer.id, customerList];
}

class CustomerSelectionClearedState extends CustomerState {
  CustomerSelectionClearedState(
      {required CustomerList customerList,
      required Customer selectedCustomer})
      : super(customerList: customerList, customer: selectedCustomer);
  @override
  List<Object> get props => [selectedCustomer.id, customerList];
}


