import 'package:cinetix_id/domain/entities/movie.dart';
import 'package:cinetix_id/presentation/misc/constant.dart';
import 'package:cinetix_id/presentation/misc/method.dart';
import 'package:cinetix_id/presentation/providers/movie/movie_detail_provider.dart';
import 'package:cinetix_id/presentation/providers/router/router_provider.dart';
import 'package:cinetix_id/presentation/widgets/back_navigation_bar.dart';
import 'package:cinetix_id/presentation/widgets/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'methdos/background.dart';

class DetailMoviePage extends ConsumerWidget {
  final Movie movie;
  const DetailMoviePage({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var asyncMovieDetail = ref.watch(MovieDetailProvider(movie: movie));

    return Scaffold(
      body: Stack(
        children: [
          ...background(movie),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackNavigationBar(
                      title: movie.title,
                      onTap: () {
                        ref.read(routerProvider).pop();
                      },
                    ),
                    verticalSpace(24),
                    NetworkImageCard(
                      width: MediaQuery.of(context).size.width - 48,
                      height: (MediaQuery.of(context).size.width - 48) * 0.6,
                      borderRadius: 16,
                      imageUrl: asyncMovieDetail.valueOrNull != null
                          ? 'https://image.tmdb.org/t/p/w500${asyncMovieDetail.value!.backdropPath ?? movie.posterPath}'
                          : null,
                      fit: BoxFit.cover,
                    ),
                    verticalSpace(24),
                    //title
                    // ...movieShortInfo(),
                    verticalSpace(20),
                    // ...movieOverview(),
                    verticalSpace(40),
                  ],
                ),
              ),
              // ...castAndCrew(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.backgroundColor,
                        backgroundColor: AppColors.saffron,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {},
                    child: const Text('Book this movie')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
