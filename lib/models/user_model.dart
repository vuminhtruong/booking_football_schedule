import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String image;
  String phone;
  String? address;
  Timestamp? birthday;

  User(
    this.address,
    this.birthday, {
    required this.name,
    required this.image,
    required this.phone,
  });
}
