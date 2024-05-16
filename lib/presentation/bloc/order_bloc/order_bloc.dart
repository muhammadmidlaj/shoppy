import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/core/network/connection_checker.dart';
import 'package:shoppy/core/constants/text_constants.dart';
import 'package:shoppy/domain/entity/customer.dart';
import 'package:shoppy/domain/entity/order.dart';
import 'package:shoppy/domain/entity/product.dart';
import 'package:shoppy/domain/usecase/create_order_usecase.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CreateOrderUsecase _createOrderUsecase;
  final ConnectionChecker _connectionChecker;
  OrderBloc(
      {required CreateOrderUsecase createOrderUsecase,
      required ConnectionChecker connectionChecker})
      : _createOrderUsecase = createOrderUsecase,
        _connectionChecker = connectionChecker,
        super(OrderInitialState()) {
    on<OrderCreateEvent>(_createOrderhandler);
  }

  Future<void> _createOrderhandler(
      OrderCreateEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoadingState());
    bool isConnected = await _connectionChecker.isConnected;
    if (!isConnected) {
      emit(const OrderFailureState(message: AppTexts.noInternetMessage));
      return;
    }

    final response = await _createOrderUsecase.call(CreateOrderParams(
        customer: event.customer,
        totalAmount: event.totalAmount,
        products: event.products));

    log("selected Customer : ${event.customer.name}");

    response.fold((failure) {
      log(failure.toString());
      emit(OrderFailureState(message: failure.message));
    }, (result) {
      log(result.message);
      emit(OrderCreatedState(order: result));
    });
  }
}
