import 'package:cinetix_id/domain/entities/movie_detail.dart';
import 'package:cinetix_id/presentation/misc/method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> movieShortInfo({
  required AsyncValue<MovieDetail?> asyncMovieDetail,
  required BuildContext context,
}) =>
    [
      Row(
        children: [
          SizedBox(
            height: 14,
            width: 14,
            child: Image.asset('assets/icons/duration.png'),
          ),
          horizontalSpace(6),
          SizedBox(
            width: 95,
            child: Text('${asyncMovieDetail.when(
              data: (data) => data != null ? data.runtime : '-',
              error: (error, stackTrace) => '-',
              loading: () => '-',
            )} minutes'),
          ),
          SizedBox(
            width: 14,
            height: 14,
            child: Image.asset('assets/icons/genre.png'),
          ),
          horizontalSpace(6),
          SizedBox(
            width:
                MediaQuery.of(context).size.width - 48 - 95 - 14 - 14 - 6 - 6,
            child: asyncMovieDetail.when(
              data: (data) {
                String genres = data?.genres.join(', ') ?? '-';

                return Text(
                  genres,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                );
              },
              error: (error, stackTrace) => const Text(
                '-',
                style: TextStyle(fontSize: 12),
              ),
              loading: () => const Text(
                '-',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      verticalSpace(12),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 18,
            width: 18,
            child: Image.asset('assets/icons/star.png'),
          ),
          horizontalSpace(6),
          Text((asyncMovieDetail.valueOrNull?.voteAverage ?? 0)
              .toStringAsFixed(1)),
        ],
      )
    ];
