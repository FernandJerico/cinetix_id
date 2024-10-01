import 'package:cinetix_id/domain/usecases/logout/logout.dart';
import 'package:cinetix_id/presentation/providers/repositories/authtentication/authentication_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout_provider.g.dart';

@riverpod
Logout logout(LogoutRef ref) =>
    Logout(authentication: ref.watch(authenticationProvider));
