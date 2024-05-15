import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoppy/core/network/connection_checker.dart';
import 'package:shoppy/core/usecase/usecase.dart';
import 'package:shoppy/core/utils/hive_constants.dart';
import 'package:shoppy/core/utils/text_constants.dart';
import 'package:shoppy/domain/entity/customer.dart';
import 'package:shoppy/domain/entity/customer_hive_model.dart';
import 'package:shoppy/domain/mappers/customer_mapper.dart';
import 'package:shoppy/domain/usecase/fetch_customers_usecase.dart';
import 'package:shoppy/domain/usecase/search_customer_usecase.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final FetchCustomersUseCase _fetchCustomersUseCase;
  final ConnectionChecker _connectionChecker;
  final SearchCustomerUseCase _searchCustomerUseCase;
  CustomerBloc(
      {required FetchCustomersUseCase fetchCustomersUseCase,
      required ConnectionChecker connectionChecker,
      required SearchCustomerUseCase searchCustomerUseCase})
      : _fetchCustomersUseCase = fetchCustomersUseCase,
        _connectionChecker = connectionChecker,
        _searchCustomerUseCase = searchCustomerUseCase,
        super(CustomerInitialState()) {
    on<CustomerFetchEvent>(_fetchCustomerHandler);
    on<CustomerSelectEvent>(_customerSelectionHandler);
    on<CustomerSelctionClearEvent>(_customerSelectionClearHandler);
    on<CustomerSearchEvent>(_customerSearchHandler);
  }

  List<Customer> _customerList = [];

  Future<void> _fetchCustomerHandler(
      CustomerFetchEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerLoadingState());
    bool isConnected = await _connectionChecker.isConnected;
    if (!isConnected) {
      final List<Customer> cachedData = await _getCustomersFromHive();
      if (cachedData.isEmpty) {
        emit(CustomerFailureState(AppTexts.noInternetMessage));
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

  Future<void> _customerSelectionClearHandler(
      CustomerSelctionClearEvent event, Emitter<CustomerState> emit) async {
    for (Customer customer in _customerList) {
      customer.isSelected = false;
    }
    emit(CustomerSelectedState(
        customerList: _customerList, selectedCustomer: Customer.empty()));
  }

  Future<void> _customerSearchHandler(
      CustomerSearchEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerLoadingState());
    bool isConnected = await _connectionChecker.isConnected;
    if (!isConnected) {
      emit(CustomerFailureState(AppTexts.noInternetMessage));
      return;
    }

    final response = await _searchCustomerUseCase
        .call(SearchCustomerParams(searchText: event.searchText));
    response.fold((failure) {
      emit(CustomerFailureState(failure.message));
    }, (result) {
      emit(CustomerLoadedState(customers: result));
    });
  }
}

_insertCustomersToHive(List<Customer> customerList) async {
  try {
    final customerBox = Hive.box<CustomerHiveModel>(HiveConstants.customerBox);

    await customerBox.clear();
    final List<CustomerHiveModel> hiveList =
        CustomerMapper.toHiveList(customerList);
    customerBox.addAll(hiveList);
  } catch (e) {
    log("failed to save customer to hive $e");
  }
}

Future<List<Customer>> _getCustomersFromHive() async {
  try {
    final customerBox = Hive.box<CustomerHiveModel>(HiveConstants.customerBox);
    final List<CustomerHiveModel> hiveList = customerBox.values.toList();
    return CustomerMapper.toCustomerList(hiveList);
  } catch (e) {
    log("failed to fetch customer from hive $e");
    return [];
  }
}
