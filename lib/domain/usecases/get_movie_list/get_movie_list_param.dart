enum GetMovieListCategories { nowPlaying, upcoming }

class GetMovieListParam {
  final int page;
  final GetMovieListCategories category;

  GetMovieListParam({this.page = 1, required this.category});
}
