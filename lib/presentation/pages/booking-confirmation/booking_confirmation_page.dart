import 'package:cinetix_id/domain/entities/movie_detail.dart';
import 'package:cinetix_id/domain/entities/result.dart';
import 'package:cinetix_id/domain/usecases/create_transaction/create_transaction.dart';
import 'package:cinetix_id/domain/usecases/create_transaction/create_transaction_param.dart';
import 'package:cinetix_id/presentation/extensions/build_context_extension.dart';
import 'package:cinetix_id/presentation/extensions/int_extension.dart';
import 'package:cinetix_id/presentation/misc/constant.dart';
import 'package:cinetix_id/presentation/misc/method.dart';
import 'package:cinetix_id/presentation/pages/booking-confirmation/method/transaction_row.dart';
import 'package:cinetix_id/presentation/providers/router/router_provider.dart';
import 'package:cinetix_id/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:cinetix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:cinetix_id/presentation/widgets/back_navigation_bar.dart';
import 'package:cinetix_id/presentation/widgets/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/transaction.dart';
import '../../providers/usecases/create_transaction_provider.dart';
import '../../widgets/buttons.dart';

class BookingConfirmationPage extends ConsumerWidget {
  final (MovieDetail, Transaction) transactionDetail;

  const BookingConfirmationPage({required this.transactionDetail, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var (movieDetail, transaction) = transactionDetail;

    transaction = transaction.copyWith(
      total: transaction.ticketAmount! * transaction.ticketPrice! +
          transaction.adminFee,
    );

    final sizes = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
            child: Column(
              children: [
                BackNavigationBar(
                  title: 'Booking Confirmation',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(24),
                NetworkImageCard(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500${movieDetail.backdropPath ?? movieDetail.posterPath}',
                  width: sizes.width - 48,
                  height: (sizes.width - 48) * 0.6,
                  borderRadius: 16,
                  fit: BoxFit.cover,
                ),
                verticalSpace(24),
                SizedBox(
                  width: sizes.width - 48,
                  child: Text(
                    transaction.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                verticalSpace(6),
                const Divider(color: AppColors.whiteColor),
                verticalSpace(6),
                transactionRow(
                    title: 'Showing Date',
                    value: DateFormat('EEEE, d MMMM y').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            transaction.watchingTime ?? 0)),
                    width: sizes.width - 48),
                transactionRow(
                    title: 'Theater',
                    value: '${transaction.theatherName}',
                    width: sizes.width - 48),
                transactionRow(
                    title: 'Seat Number',
                    value: transaction.seats.join(', '),
                    width: sizes.width - 48),
                transactionRow(
                    title: '# of tickets',
                    value: '${transaction.ticketAmount} tickets',
                    width: sizes.width - 48),
                transactionRow(
                    title: 'Ticket Price',
                    value: '${transaction.ticketPrice?.toIDRCurrencyFormat()}',
                    width: sizes.width - 48),
                transactionRow(
                    title: 'Admin Fee',
                    value: transaction.adminFee.toIDRCurrencyFormat(),
                    width: sizes.width - 48),
                const Divider(color: AppColors.whiteColor),
                transactionRow(
                    title: 'Total Price',
                    value: transaction.total.toIDRCurrencyFormat(),
                    width: sizes.width - 48),
                Button.filled(
                  borderRadius: 10,
                  onPressed: () async {
                    int transactionTime = DateTime.now().millisecondsSinceEpoch;

                    transaction = transaction.copyWith(
                        transactionTime: transactionTime,
                        id: 'ctx-$transactionTime-${transaction.uid}');

                    CreateTransaction createTransaction =
                        ref.read(createTransactionProvider);

                    await createTransaction(
                            CreateTransactionParam(transaction: transaction))
                        .then(
                      (result) {
                        switch (result) {
                          case Success(data: _):
                            ref
                                .read(transactionDataProvider.notifier)
                                .refreshTransactionData();
                            ref
                                .read(userDataProvider.notifier)
                                .refreshUserData();
                            ref.read(routerProvider).goNamed('main');
                          case Failed(:final message):
                            if (context.mounted) {
                              context.showSnackBar(message);
                            }
                        }
                      },
                    );
                  },
                  label: 'Pay Now',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
