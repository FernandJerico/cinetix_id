import 'package:cinetix_id/domain/entities/transaction.dart';
import 'package:cinetix_id/domain/usecases/get_transcation/get_transaction_param.dart';
import 'package:cinetix_id/domain/usecases/usecase.dart';

import '../../../data/repositories/transaction_repository.dart';
import '../../entities/result.dart';

class GetTransaction
    implements UseCase<Result<List<Transaction>>, GetTransactionParam> {
  final TransactionRepository _transactionRepository;

  GetTransaction({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;
  @override
  Future<Result<List<Transaction>>> call(GetTransactionParam params) async {
    var transactionListResult =
        await _transactionRepository.getUserTransactions(uid: params.uid);

    return switch (transactionListResult) {
      Success(data: final transactionList) => Result.success(transactionList),
      Failed(:final message) => Result.failed(message)
    };
  }
}
