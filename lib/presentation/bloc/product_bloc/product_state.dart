part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {
  const ProductLoadingState();
}

class ProductLoadedState extends ProductState {
  final ProductList products;
  const ProductLoadedState(this.products);

  @override
  List<Object> get props => [products];
}

class ProductFailureState extends ProductState {
  final String message;

  const ProductFailureState(this.message);
  @override
  List<String> get props => [message];
}
