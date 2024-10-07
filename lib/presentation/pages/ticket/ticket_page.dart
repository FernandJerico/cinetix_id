import 'package:cinetix_id/presentation/widgets/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/transaction_data/transaction_data_provider.dart';

class TicketPage extends ConsumerWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: ref.watch(transactionDataProvider).when(
                data: (transactions) => (transactions
                        .where((e) =>
                            e.title != 'Top Up' &&
                            e.watchingTime! >=
                                DateTime.now().millisecondsSinceEpoch)
                        .toList()
                      ..sort(
                        (a, b) => a.watchingTime!.compareTo(b.watchingTime!),
                      ))
                    .map((transaction) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Ticket(transaction: transaction),
                        ))
                    .toList(),
                error: (error, stackTrace) => [],
                loading: () => const [CircularProgressIndicator()],
              ),
        )
      ],
    );
  }
}
