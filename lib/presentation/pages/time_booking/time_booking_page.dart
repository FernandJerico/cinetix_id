// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinetix_id/domain/entities/movie_detail.dart';
import 'package:cinetix_id/presentation/widgets/selectable_card.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 50,
          child: SelectableCard(
            text: 'XXI CSB Mall',
            onTap: () {},
            isSelected: true,
          ),
        ),
      ),
    );
  }
}
