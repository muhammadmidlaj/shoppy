import 'package:shoppy/core/utils/typedef.dart';
import 'package:shoppy/domain/entity/customer.dart';
import 'package:shoppy/domain/entity/customer_hive_model.dart';

class CustomerMapper {
  static CustomerHiveModel toHiveModel(Customer customer) => CustomerHiveModel(
      id: customer.id,
      name: customer.name,
      profilePic: customer.profilePic,
      mobileNumber: customer.mobileNumber,
      email: customer.email,
      street: customer.street,
      streetTwo: customer.streetTwo,
      city: customer.city,
      pincode: customer.pincode,
      country: customer.country,
      state: customer.state,
      createdDate: customer.createdDate,
      createdTime: customer.createdTime,
      modifiedDate: customer.modifiedDate,
      modifiedTime: customer.modifiedTime,
      flag: customer.flag);

  static Customer toCustomer(CustomerHiveModel customer) => Customer(
      id: customer.id,
      name: customer.name,
      profilePic: customer.profilePic,
      mobileNumber: customer.mobileNumber,
      email: customer.email,
      street: customer.street,
      streetTwo: customer.streetTwo,
      city: customer.city,
      pincode: customer.pincode,
      country: customer.country,
      state: customer.state,
      createdDate: customer.createdDate,
      createdTime: customer.createdTime,
      modifiedDate: customer.modifiedDate,
      modifiedTime: customer.modifiedTime,
      flag: customer.flag);

  static List<CustomerHiveModel> toHiveList(CustomerList customers) =>
      customers.map((customer) => toHiveModel(customer)).toList();
  static CustomerList toCustomerList(List<CustomerHiveModel> customers) =>
      customers.map((customer) => toCustomer(customer)).toList();
}
