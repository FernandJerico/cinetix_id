import 'package:cinetix_id/domain/entities/result.dart';
import 'package:cinetix_id/domain/entities/transaction.dart';
import 'package:cinetix_id/domain/usecases/get_transcation/get_transaction.dart';
import 'package:cinetix_id/domain/usecases/get_transcation/get_transaction_param.dart';
import 'package:cinetix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/user.dart';
import '../usecases/get_transaction_provider.dart';

part 'transaction_data_provider.g.dart';

@Riverpod(keepAlive: true)
class TransactionData extends _$TransactionData {
  @override
  Future<List<Transaction>> build() async {
    User? user = ref.read(userDataProvider).valueOrNull;

    if (user != null) {
      state = const AsyncLoading();

      GetTransaction getTransaction = ref.read(getTransactionProvider);

      var result = await getTransaction(GetTransactionParam(uid: user.uid));

      if (result case Success(data: final data)) {
        return data;
      }
    }

    return [];
  }

  Future<void> refreshTransactionData() async {
    User? user = ref.read(userDataProvider).valueOrNull;

    if (user != null) {
      state = const AsyncLoading();

      GetTransaction getTransaction = ref.read(getTransactionProvider);

      var result = await getTransaction(GetTransactionParam(uid: user.uid));

      switch (result) {
        case Success(data: final data):
          state = AsyncData(data);
        case Failed(message: final message):
          state = AsyncError(FlutterError(message), StackTrace.current);
          state = AsyncData(state.valueOrNull ?? const []);
      }
    }
  }
}
