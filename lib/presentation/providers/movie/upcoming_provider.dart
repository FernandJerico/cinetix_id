import 'package:cinetix_id/domain/entities/movie.dart';
import 'package:cinetix_id/domain/entities/result.dart';
import 'package:cinetix_id/domain/usecases/get_movie_list/get_movie_list.dart';
import 'package:cinetix_id/domain/usecases/get_movie_list/get_movie_list_param.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../usecases/get_movie_list_provider.dart';

part 'upcoming_provider.g.dart';

@Riverpod(keepAlive: true)
class Upcoming extends _$Upcoming {
  @override
  FutureOr<List<Movie>> build() => const [];

  Future<void> getMovies({int page = 1}) async {
    state = const AsyncLoading();

    GetMovieList getMovieList = ref.read(getMovieListProvider);

    final result = await getMovieList(GetMovieListParam(
        category: GetMovieListCategories.upcoming, page: page));

    switch (result) {
      case Success(data: final movies):
        state = AsyncData(movies);
      case Failed(message: _):
        state = const AsyncData([]);
    }
  }
}
