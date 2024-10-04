import 'package:flutter/material.dart';

import '../misc/constant.dart';

enum SeatStatus { available, reserved, selected }

class Seat extends StatelessWidget {
  final int? number;
  final SeatStatus status;
  final double size;
  final VoidCallback? onTap;

  const Seat(
      {super.key,
      this.number,
      this.status = SeatStatus.available,
      this.size = 24,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: status == SeatStatus.available
                ? Colors.white
                : status == SeatStatus.reserved
                    ? Colors.grey
                    : AppColors.primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(number?.toString() ?? '',
                style: const TextStyle(
                    color: AppColors.backgroundColor,
                    fontWeight: FontWeight.bold)),
          ),
        ));
  }
}
