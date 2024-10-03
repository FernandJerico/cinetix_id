import 'package:cinetix_id/presentation/misc/method.dart';
import 'package:cinetix_id/presentation/pages/movie/methdos/user_info.dart';
import 'package:cinetix_id/presentation/providers/movie/upcoming_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/movie/now_playing_provider.dart';
import 'methdos/movie_list.dart';
import 'methdos/promotion_list.dart';
import 'methdos/search_bar.dart';

class MoviePage extends ConsumerWidget {
  final List<String> promotionImageFilename = const [
    'popcorn.jpg',
    'buy1get1.jpg',
  ];

  const MoviePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(12),
            userInfo(ref),
            verticalSpace(40),
            searchBar(context),
            verticalSpace(24),
            ...movieList(
              title: 'Now Playing',
              movies: ref.watch(nowPlayingProvider),
              onTap: (movie) {},
            ),
            verticalSpace(30),
            ...promotionList(promotionImageFilename),
            verticalSpace(30),
            ...movieList(
              title: 'Upcoming',
              movies: ref.watch(upcomingProvider),
              onTap: (movie) {},
            ),
            verticalSpace(100),
          ],
        )
      ],
    );
  }
}
