import 'package:cinetix_id/data/repositories/authentication.dart';
import 'package:cinetix_id/data/repositories/user_repository.dart';
import 'package:cinetix_id/domain/entities/result.dart';
import 'package:cinetix_id/domain/entities/user.dart';
import 'package:cinetix_id/domain/usecases/login/login_params.dart';
import 'package:cinetix_id/domain/usecases/usecase.dart';

class Login implements UseCase<Result<User>, LoginParams> {
  final Authentication authentication;
  final UserRepository userRepository;

  Login({required this.authentication, required this.userRepository});

  @override
  Future<Result<User>> call(LoginParams params) async {
    var idResult = await authentication.login(
        email: params.email, password: params.password);

    if (idResult is Success) {
      var userResult = await userRepository.getUser(uid: idResult.resultValue!);

      return switch (userResult) {
        Success(data: final user) => Result.success(user),
        Failed(:final message) => Result.failed(message),
      };
    } else {
      return Result.failed(idResult.errorMessage!);
    }
  }
}
