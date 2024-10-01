import 'dart:io';

import 'package:cinetix_id/data/repositories/user_repository.dart';
import 'package:cinetix_id/domain/entities/result.dart';
import 'package:cinetix_id/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseFirestore _firestore;

  FirebaseUserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<Result<String>> createUser(
      {required String uid,
      required String email,
      required String name,
      String? photoUrl,
      int balance = 0}) async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        _firestore.collection('users');

    await collectionReference.doc(uid).set({
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'balance': balance
    });

    DocumentSnapshot<Map<String, dynamic>> result =
        await collectionReference.doc(uid).get();

    if (result.exists) {
      return Result.success(User.fromJson(result.data()!).uid);
    } else {
      return const Result.failed('Failed to create user data');
    }
  }

  @override
  Future<Result<User>> getUser({required String uid}) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        _firestore.doc('users/$uid');

    DocumentSnapshot<Map<String, dynamic>> result =
        await documentReference.get();

    if (result.exists) {
      return Result.success(User.fromJson(result.data()!));
    } else {
      return const Result.failed('User not found');
    }
  }

  @override
  Future<Result<int>> getUserBalance({required String uid}) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        _firestore.doc('users/$uid');

    DocumentSnapshot<Map<String, dynamic>> result =
        await documentReference.get();

    if (result.exists) {
      return Result.success(result.data()!['balance']);
    } else {
      return const Result.failed('User not found');
    }
  }

  @override
  Future<Result<User>> updateProfilePicture(
      {required User user, required File photoUrl}) async {
    String fileName = basename(photoUrl.path);

    Reference reference =
        FirebaseStorage.instance.ref().child('profile/$fileName');
    try {
      await reference.putFile(photoUrl);

      String downloadUrl = await reference.getDownloadURL();

      var updatedResult =
          await updateUser(user: user.copyWith(photoUrl: downloadUrl));

      if (updatedResult.isSuccess) {
        return Result.success(updatedResult.resultValue!);
      } else {
        return Result.failed(updatedResult.errorMessage!);
      }
    } catch (e) {
      return const Result.failed('Failed to upload profile picture');
    }
  }

  @override
  Future<Result<User>> updateUser({required User user}) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          _firestore.doc('users/${user.uid}');

      await documentReference.update(user.toJson());

      DocumentSnapshot<Map<String, dynamic>> result =
          await documentReference.get();

      if (result.exists) {
        User updateUser = User.fromJson(result.data()!);

        if (updateUser == user) {
          return Result.success(updateUser);
        } else {
          return const Result.failed('Failed to update user data');
        }
      } else {
        return const Result.failed('Failed to update user data');
      }
    } on FirebaseException catch (e) {
      return Result.failed(e.message ?? 'Failed to update user data');
    }
  }

  @override
  Future<Result<User>> updateUserBalance(
      {required String uid, required int balance}) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        _firestore.doc('users/$uid');

    DocumentSnapshot<Map<String, dynamic>> result =
        await documentReference.get();

    if (result.exists) {
      await documentReference.update({'balance': balance});

      DocumentSnapshot<Map<String, dynamic>> updatedResult =
          await documentReference.get();

      if (updatedResult.exists) {
        User updatedUser = User.fromJson(updatedResult.data()!);

        if (updatedUser.balance == balance) {
          return Result.success(updatedUser);
        } else {
          return const Result.failed('Failed to update user balance');
        }
      } else {
        return const Result.failed('Failed to retrieve updated user balance');
      }
    } else {
      return const Result.failed('User not found');
    }
  }
}
