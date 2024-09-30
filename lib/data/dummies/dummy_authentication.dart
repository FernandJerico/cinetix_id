import 'package:cinetix_id/data/repositories/authentication.dart';
import 'package:cinetix_id/domain/entities/result.dart';

class DummyAuthentication implements Authentication {
  @override
  String? getLoggedInUserId() {
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> login(
      {required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 1));

    return const Result.success('ID-1234');
    // return const Result.failed('Gagal login');
  }

  @override
  Future<Result<String>> logout() {
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> register(
      {required String email, required String password}) {
    throw UnimplementedError();
  }
}
