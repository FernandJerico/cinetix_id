import 'package:cinetix_id/domain/entities/transaction.dart';
import 'package:cinetix_id/presentation/misc/method.dart';
import 'package:cinetix_id/presentation/widgets/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Ticket extends StatelessWidget {
  final Transaction transaction;

  const Ticket({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xFF252836),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Text(
              transaction.id.toString(),
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: NetworkImageCard(
                  width: 75,
                  height: 114,
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500${transaction.transactionImage}',
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    verticalSpace(10),
                    Text(
                      transaction.theatherName.toString(),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat('EEEE, d MMMM y').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              transaction.watchingTime ?? 0)),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    verticalSpace(10),
                    Text(
                      '${transaction.ticketAmount} Tickets (${transaction.seats.join(', ')})',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
