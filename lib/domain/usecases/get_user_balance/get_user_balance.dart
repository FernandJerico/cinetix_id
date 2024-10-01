import 'package:cinetix_id/data/repositories/user_repository.dart';
import 'package:cinetix_id/domain/entities/result.dart';
import 'package:cinetix_id/domain/usecases/get_user_balance/get_user_balance_param.dart';
import 'package:cinetix_id/domain/usecases/usecase.dart';

class GetUserBalance implements UseCase<Result<int>, GetUserBalanceParam> {
  final UserRepository _userRepository;

  GetUserBalance({required UserRepository userRepository})
      : _userRepository = userRepository;
  @override
  Future<Result<int>> call(GetUserBalanceParam params) async =>
      _userRepository.getUserBalance(uid: params.userId);
}
