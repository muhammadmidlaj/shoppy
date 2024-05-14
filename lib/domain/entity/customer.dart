// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final int id;
  final String name;
  final String? profilePic;
  final String mobileNumber;
  final String email;
  final String street;
  final String streetTwo;
  final String city;
  final int pincode;
  final String country;
  final String state;
  final DateTime createdDate;
  final String createdTime;
  final DateTime modifiedDate;
  final String modifiedTime;
  final bool flag;
  bool isSelected;

  Customer(
      {required this.id,
      required this.name,
      required this.profilePic,
      required this.mobileNumber,
      required this.email,
      required this.street,
      required this.streetTwo,
      required this.city,
      required this.pincode,
      required this.country,
      required this.state,
      required this.createdDate,
      required this.createdTime,
      required this.modifiedDate,
      required this.modifiedTime,
      required this.flag,
      this.isSelected = false});

  Customer.empty()
      : this(
          id: -1,
          name: '',
          profilePic: '',
          mobileNumber: '',
          email: '',
          street: '',
          streetTwo: '',
          city: '',
          country: '',
          state: '',
          createdDate: DateTime.now(),
          createdTime: '',
          modifiedDate: DateTime.now(),
          modifiedTime: '',
          pincode: -1,
          flag: false,
        );

  @override
  List<Object?> get props => [id, name, mobileNumber, email];
}
