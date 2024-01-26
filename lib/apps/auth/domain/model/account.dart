import 'package:donate/apps/auth/domain/model/position.dart';
import 'package:flutter/material.dart';

@immutable
class Account {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? bloodType;
  final Position? position;
  const Account(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      this.bloodType,
      this.position});
}
