import 'package:cinetix_id/domain/entities/movie_detail.dart';
import 'package:cinetix_id/domain/entities/result.dart';
import 'package:cinetix_id/domain/usecases/get_movie_detail/get_movie_detail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_movie_detail/get_movie_detail_param.dart';
import '../usecases/get_movie_detail_provider.dart';

part 'movie_detail_provider.g.dart';

@riverpod
Future<MovieDetail?> movieDetail(MovieDetailRef ref,
    {required Movie movie}) async {
  GetMovieDetail getMovieDetail = ref.read(getMovieDetailProvider);

  var movieDetailResult =
      await getMovieDetail(GetMovieDetailParam(movie: movie));

  return switch (movieDetailResult) {
    Success(data: final movieDetail) => movieDetail,
    Failed(message: _) => null,
  };
}
