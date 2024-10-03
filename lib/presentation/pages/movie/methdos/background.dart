import 'package:flutter/material.dart';

import '../../../../domain/entities/movie.dart';
import '../../../misc/constant.dart';

List<Widget> background(Movie movie) => [
      Image.network(
        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
        fit: BoxFit.cover,
        height: double.infinity,
      ),
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: const Alignment(0, 0.3),
              end: Alignment.topCenter,
              colors: [
                AppColors.backgroundColor.withOpacity(1),
                AppColors.backgroundColor.withOpacity(0.7),
              ]),
        ),
      )
    ];
