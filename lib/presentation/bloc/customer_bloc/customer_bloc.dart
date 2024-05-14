import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoppy/core/network/connection_checker.dart';
import 'package:shoppy/core/usecase/usecase.dart';
import 'package:shoppy/core/utils/hive_constants.dart';
import 'package:shoppy/domain/entity/customer.dart';
import 'package:shoppy/domain/entity/customer_hive_model.dart';
import 'package:shoppy/domain/mappers/customer_mapper.dart';
import 'package:shoppy/domain/usecase/fetch_customers_usecase.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final FetchCustomersUseCase _fetchCustomersUseCase;
  final ConnectionChecker _connectionChecker;
  CustomerBloc(
      {required FetchCustomersUseCase fetchCustomersUseCase,
      required ConnectionChecker connectionChecker})
      : _fetchCustomersUseCase = fetchCustomersUseCase,
        _connectionChecker = connectionChecker,
        super(CustomerInitialState()) {
    on<CustomerFetchEvent>(_fetchCustomerHandler);
    on<CustomerSelectEvent>(_customerSelectionHandler);
  }

  List<Customer> _customerList = [];

  Future<void> _fetchCustomerHandler(
      CustomerFetchEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerLoadingState());
    bool isConnected = await _connectionChecker.isConnected;
    if (!isConnected) {
      final List<Customer> cachedData = await _getCustomersFromHive();
      if (cachedData.isEmpty) {
        emit(CustomerFailureState(
            "Oops! It seems you're offline. Please check your internet connection"));
      } else {
        _customerList = cachedData;
        emit(CustomerLoadedState(customers: cachedData));
      }
      return;
    }
    final response = await _fetchCustomersUseCase.call(NoParams());
    response.fold((failure) async {
      final List<Customer> cachedData = await _getCustomersFromHive();
      if (cachedData.isNotEmpty) {
        _customerList = cachedData;
        emit(CustomerLoadedState(customers: cachedData));
      } else {
        emit(CustomerFailureState(failure.message));
      }
    }, (result) {
      _insertCustomersToHive(result);
      _customerList = result;
      emit(CustomerLoadedState(customers: result));
    });
  }

  Future<List<Customer>> _getCustomersFromHive() async {
    try {
      final customerBox =
          Hive.box<CustomerHiveModel>(HiveConstants.customerBox);
      final List<CustomerHiveModel> hiveList = customerBox.values.toList();
      return CustomerMapper.toCustomerList(hiveList);
    } catch (e) {
      log("failed to fetch customer from hive $e");
      return [];
    }
  }

  _insertCustomersToHive(List<Customer> customerList) async {
    try {
      final customerBox =
          Hive.box<CustomerHiveModel>(HiveConstants.customerBox);

      await customerBox.clear();
      final List<CustomerHiveModel> hiveList =
          CustomerMapper.toHiveList(customerList);
      customerBox.addAll(hiveList);
    } catch (e) {
      log("failed to save customer to hive $e");
    }
  }

  Future<void> _customerSelectionHandler(
      CustomerSelectEvent event, Emitter<CustomerState> emit) async {
    for (Customer customer in _customerList) {
      customer.isSelected = false;
      if (customer == event.customer) {
        customer.isSelected = !customer.isSelected;
      }
    }

    emit(CustomerSelectedState(
        selectedCustomer: event.customer, customerList: _customerList));
  }
}
