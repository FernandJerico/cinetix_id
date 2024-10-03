import 'package:cinetix_id/domain/entities/movie_detail.dart';
import 'package:cinetix_id/presentation/misc/method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> movieOverview(AsyncValue<MovieDetail?> asyncMovieDetail) => [
      const Text(
        'Overview',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      verticalSpace(12),
      asyncMovieDetail.when(
        data: (data) {
          return Text(
            data != null ? data.overview : '',
            style: const TextStyle(fontSize: 14),
          );
        },
        error: (error, stackTrace) => const Text(
          'Failed to load overview. Please try again later.',
          style: TextStyle(fontSize: 14),
        ),
        loading: () => const CircularProgressIndicator(),
      ),
    ];
