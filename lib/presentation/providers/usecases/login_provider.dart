import 'package:cinetix_id/domain/usecases/login/login.dart';
import 'package:cinetix_id/presentation/providers/repositories/authtentication/authentication_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/user_repository/user_repository_provider.dart';

part 'login_provider.g.dart';

@riverpod
Login login(LoginRef ref) => Login(
    authentication: ref.watch(authenticationProvider),
    userRepository: ref.watch(userRepositoryProvider));
