// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:cinetix_id/presentation/misc/method.dart';
import 'package:cinetix_id/presentation/pages/seat-booking/method/movie_screen.dart';
import 'package:cinetix_id/presentation/pages/seat-booking/method/seat_section.dart';
import 'package:cinetix_id/presentation/providers/router/router_provider.dart';
import 'package:cinetix_id/presentation/widgets/back_navigation_bar.dart';
import 'package:cinetix_id/presentation/widgets/seat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinetix_id/domain/entities/transaction.dart';

import '../../../domain/entities/movie_detail.dart';
import '../../widgets/buttons.dart';
import 'method/legend.dart';

class SeatBookingPage extends ConsumerStatefulWidget {
  final (MovieDetail, Transaction) transactionDetail;
  const SeatBookingPage({
    super.key,
    required this.transactionDetail,
  });

  @override
  ConsumerState<SeatBookingPage> createState() => _SeatBookingPageState();
}

class _SeatBookingPageState extends ConsumerState<SeatBookingPage> {
  List<int> selectedSeats = [];
  List<int?> reservedSeats = [];

  @override
  void initState() {
    super.initState();
    Random random = Random();
    int reservedNumber = random.nextInt(36) + 1;

    while (reservedSeats.length < 8) {
      if (!reservedSeats.contains(reservedNumber)) {
        reservedSeats.add(reservedNumber);
      }
      reservedNumber = random.nextInt(36) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final (movieDetail, transaction) = widget.transactionDetail;

    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              BackNavigationBar(
                title: movieDetail.title,
                onTap: () => ref.read(routerProvider).pop(),
              ),
              movieScreen(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  seatSection(
                    seatNumber: List.generate(
                      18,
                      (index) => index + 1,
                    ),
                    onTap: onSeatTap,
                    seatStatusChecker: seatStatusChecker,
                  ),
                  horizontalSpace(30),
                  seatSection(
                    seatNumber: List.generate(
                      18,
                      (index) => index + 19,
                    ),
                    onTap: onSeatTap,
                    seatStatusChecker: seatStatusChecker,
                  ),
                ],
              ),
              verticalSpace(20),
              legend(),
              verticalSpace(40),
              Text(
                '${selectedSeats.length} seats selected',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              verticalSpace(40),
              Button.filled(borderRadius: 10, onPressed: () {}, label: 'Next')
            ],
          ),
        ),
      ],
    ));
  }

  void onSeatTap(seatNumber) {
    if (!selectedSeats.contains(seatNumber)) {
      setState(() {
        selectedSeats.add(seatNumber);
      });
    } else {
      setState(() {
        selectedSeats.remove(seatNumber);
      });
    }
  }

  SeatStatus seatStatusChecker(seatNumber) => reservedSeats.contains(seatNumber)
      ? SeatStatus.reserved
      : selectedSeats.contains(seatNumber)
          ? SeatStatus.selected
          : SeatStatus.available;
}
