import 'dart:io';

import 'package:cinetix_id/domain/entities/result.dart';
import 'package:cinetix_id/domain/usecases/get_logged_in_user/get_logged_in_user.dart';
import 'package:cinetix_id/domain/usecases/login/login.dart';
import 'package:cinetix_id/domain/usecases/register/register_param.dart';
import 'package:cinetix_id/domain/usecases/top_up/top_up.dart';
import 'package:cinetix_id/domain/usecases/top_up/top_up_param.dart';
import 'package:cinetix_id/domain/usecases/upload_profile_picture/upload_profile_picture.dart';
import 'package:cinetix_id/presentation/providers/movie/now_playing_provider.dart';
import 'package:cinetix_id/presentation/providers/movie/upcoming_provider.dart';
import 'package:cinetix_id/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:cinetix_id/presentation/providers/usecases/logout_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/login/login_params.dart';
import '../../../domain/usecases/register/register.dart';
import '../../../domain/usecases/upload_profile_picture/upload_profile_picture_param.dart';
import '../usecases/get_logged_in_user_provider.dart';
import '../usecases/login_provider.dart';
import '../usecases/register_provider.dart';
import '../usecases/top_up_provider.dart';
import '../usecases/upload_profile_picture_provider.dart';

part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  Future<User?> build() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);

    var userResult = await getLoggedInUser(null);

    switch (userResult) {
      case Success(data: final data):
        _getMovies();
        return data;
      case Failed(message: _):
        return null;
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();

    Login login = ref.read(loginProvider);

    var result = await login(LoginParams(email: email, password: password));

    switch (result) {
      case Success(data: final data):
        _getMovies();
        state = AsyncData(data);
        break;
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> register(
      {required String email,
      required String password,
      required String name,
      String? imageUrl}) async {
    state = const AsyncLoading();

    Register register = ref.read(registerProvider);

    var result = await register(RegisterParam(
        email: email, password: password, name: name, photoUrl: imageUrl));

    switch (result) {
      case Success(data: final data):
        _getMovies();
        state = AsyncData(data);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> refreshUserData() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);

    var userResult = await getLoggedInUser(null);

    if (userResult case Success(data: final data)) {
      state = AsyncData(data);
    }
  }

  Future<void> logout() async {
    var logout = ref.read(logoutProvider);
    var result = await logout(null);

    switch (result) {
      case Success(data: _):
        state = const AsyncData(null);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull);
    }
  }

  Future<void> topUp(int amount) async {
    TopUp topUp = ref.read(topUpProvider);

    String? userId = state.valueOrNull?.uid;

    if (userId != null) {
      var result = await topUp(TopUpParam(amount: amount, userId: userId));

      if (result.isSuccess) {
        refreshUserData();
        // refresh Transaction data
        ref.read(transactionDataProvider.notifier).refreshTransactionData();
      }
    }
  }

  Future<void> uploadProfilePicture(
      {required User user, required File imageFile}) async {
    UploadProfilePicture uploadProfilePicture =
        ref.read(uploadProfilePictureProvider);

    var result = await uploadProfilePicture(
        UploadProfilePictureParam(user: user, imageFile: imageFile));

    if (result case Success(data: final data)) {
      state = AsyncData(data);
    }
  }

  void _getMovies() {
    ref.read(nowPlayingProvider.notifier).getMovies();
    ref.read(upcomingProvider.notifier).getMovies();
  }
}
