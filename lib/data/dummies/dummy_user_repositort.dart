import 'dart:io';

import 'package:cinetix_id/data/repositories/user_repository.dart';
import 'package:cinetix_id/domain/entities/result.dart';
import 'package:cinetix_id/domain/entities/user.dart';

class DummyUserRepositort implements UserRepository {
  @override
  Future<Result<User>> createUser(
      {required String uid,
      required String email,
      required String name,
      String? photoUrl,
      int balance = 0}) {
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> getUser({required String uid}) async {
    await Future.delayed(const Duration(seconds: 1));

    return Result.success(
        User(uid: uid, email: 'fernand@gmail.com', name: 'Fernand'));
  }

  @override
  Future<Result<int>> getUserBalance({required String uid}) {
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateProfilePicture(
      {required User user, required File photoUrl}) {
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateUser({required User user}) {
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateUserBalance(
      {required String uid, required int balance}) {
    throw UnimplementedError();
  }
}
