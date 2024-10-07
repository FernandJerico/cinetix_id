import 'package:cinetix_id/presentation/misc/method.dart';
import 'package:cinetix_id/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:cinetix_id/presentation/widgets/transcation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> recentTransactions(WidgetRef ref) => [
      const Text(
        'Recent Transactions',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      verticalSpace(4),
      ...ref.watch(transactionDataProvider).when(
            data: (transactions) => (transactions
                  ..sort((a, b) =>
                      -a.transactionTime!.compareTo(b.transactionTime!)))
                .map(
              (transaction) => TranscationCard(transaction: transaction),
            ),
            error: (error, stackTrace) => [],
            loading: () => [const CircularProgressIndicator()],
          ),
    ];
