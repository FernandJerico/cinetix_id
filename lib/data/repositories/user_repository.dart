import 'dart:io';

import 'package:cinetix_id/domain/entities/result.dart';
import 'package:cinetix_id/domain/entities/user.dart';

abstract interface class UserRepository {
  Future<Result<String>> createUser(
      {required String uid,
      required String email,
      required String name,
      String? photoUrl,
      int balance = 0});

  Future<Result<User>> getUser({required String uid});
  Future<Result<User>> updateUser({required String uid});
  Future<Result<int>> getUserBalance({required String uid});
  Future<Result<User>> updateUserBalance(
      {required String uid, required int balance});
  Future<Result<User>> updateProfilePicture(
      {required String uid, required File photoUrl});
}
