import 'package:hive_flutter/hive_flutter.dart';
  part 'customer_hive_model.g.dart';

@HiveType(typeId: 1)
class CustomerHiveModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? profilePic;
  @HiveField(3)
  final String mobileNumber;
  @HiveField(4)
  final String email;
  @HiveField(5)
  final String street;
  @HiveField(6)
  final String streetTwo;
  @HiveField(7)
  final String city;
  @HiveField(8)
  final int pincode;
  @HiveField(9)
  final String country;
  @HiveField(10)
  final String state;
  @HiveField(11)
  final DateTime createdDate;
  @HiveField(12)
  final String createdTime;
  @HiveField(13)
  final DateTime modifiedDate;
  @HiveField(14)
  final String modifiedTime;
  @HiveField(15)
  final bool flag;

  CustomerHiveModel(
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
      required this.flag});
}
