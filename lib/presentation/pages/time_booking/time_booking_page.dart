// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinetix_id/presentation/extensions/build_context_extension.dart';
import 'package:cinetix_id/presentation/misc/method.dart';
import 'package:cinetix_id/presentation/providers/router/router_provider.dart';
import 'package:cinetix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:cinetix_id/presentation/widgets/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinetix_id/domain/entities/movie_detail.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/transaction.dart';
import '../../misc/constant.dart';
import '../../widgets/back_navigation_bar.dart';
import 'method/options.dart';

class TimeBookingPage extends ConsumerStatefulWidget {
  final MovieDetail movieDetail;
  const TimeBookingPage({
    super.key,
    required this.movieDetail,
  });

  @override
  ConsumerState<TimeBookingPage> createState() => _TimeBookingPageState();
}

class _TimeBookingPageState extends ConsumerState<TimeBookingPage> {
  final List<String> theaters = [
    'XXI CSB Mall Cirebon',
    'XXI Grage Mall Cirebon',
    'CGV Grage City Mall Cirebon',
    'CGV Transmart Cirebon',
  ];

  final List<DateTime> dates = List.generate(
    7,
    (index) {
      DateTime now = DateTime.now();
      DateTime date = DateTime(now.year, now.month, now.day);
      return date.add(Duration(days: index));
    },
  );

  final List<int> hours = List.generate(8, (index) => index + 11);

  String? selectedTheater;
  DateTime? selectedDate;
  int? selectedHour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: BackNavigationBar(
                title: widget.movieDetail.title,
                onTap: () {
                  ref.read(routerProvider).pop();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: NetworkImageCard(
                width: MediaQuery.of(context).size.width - 48,
                height: (MediaQuery.of(context).size.width - 48) * 0.6,
                borderRadius: 16,
                imageUrl:
                    'https://image.tmdb.org/t/p/w500${widget.movieDetail.backdropPath ?? widget.movieDetail.posterPath}',
                fit: BoxFit.cover,
              ),
            ),
            ...options(
              title: 'Select a theater',
              options: theaters,
              selectedItem: selectedTheater,
              onTap: (object) {
                setState(() {
                  selectedTheater = object;
                });
              },
            ),
            verticalSpace(24),
            ...options(
              title: 'Select a date',
              options: dates,
              selectedItem: selectedDate,
              converter: (date) => DateFormat('EEE, d MMMM').format(date),
              onTap: (object) {
                setState(() {
                  selectedDate = object;
                });
              },
            ),
            verticalSpace(24),
            ...options(
              title: 'Select a hour',
              options: hours,
              selectedItem: selectedHour,
              converter: (hour) => '$hour:00',
              isOptionEnabled: (hour) =>
                  selectedDate != null &&
                  DateTime(
                    selectedDate!.year,
                    selectedDate!.month,
                    selectedDate!.day,
                    hour,
                  ).isAfter(DateTime.now()),
              onTap: (object) {
                setState(() {
                  selectedHour = object;
                });
              },
            ),
            verticalSpace(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.whiteColor,
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (selectedDate == null ||
                        selectedHour == null ||
                        selectedTheater == null) {
                      context.showSnackBar('Please select all options');
                    } else {
                      Transaction transaction = Transaction(
                          uid: ref.read(userDataProvider).value!.uid,
                          title: widget.movieDetail.title,
                          adminFee: 3000,
                          total: 0,
                          watchingTime: DateTime(
                            selectedDate!.year,
                            selectedDate!.month,
                            selectedDate!.day,
                            selectedHour!,
                          ).millisecondsSinceEpoch,
                          transactionImage: widget.movieDetail.posterPath,
                          theatherName: selectedTheater);

                      ref.read(routerProvider).pushNamed('seat-booking',
                          extra: (widget.movieDetail, transaction));
                    }
                  },
                  child: const Text('Next'),
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
