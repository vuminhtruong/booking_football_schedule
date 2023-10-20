import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String image;
  String phone;
  String? address;
  String? birthday;

  UserModel(
    this.address,
    this.birthday, {
    required this.name,
    required this.image,
    required this.phone,
  });
}
