import 'package:cinetix_id/data/repositories/movie_repository.dart';
import 'package:cinetix_id/domain/entities/movie.dart';
import 'package:cinetix_id/domain/entities/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TmdbMovieRepository implements MovieRepository {
  final Dio? dio;
  final String _accessToken = '${dotenv.env['APIReadAccessToken']}';

  late final Options _options = Options(headers: {
    'Authorization': 'Bearer $_accessToken',
    'accept': 'application/json',
  });

  TmdbMovieRepository({Dio? dio}) : dio = dio ?? Dio();

  @override
  Future<Result<List<Movie>>> getActors({required int id}) async {
    try {
      final response = await dio!.get(
          'https://api.themoviedb.org/3/movie/$id/credits?language=en-US',
          options: _options);

      final result = List<Map<String, dynamic>>.from(response.data['cast']);

      return Result.success(result.map((e) => Movie.fromJSON(e)).toList());
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  @override
  Future<Result<List<Movie>>> getDetail({required int id}) async {
    try {
      final response = await dio!.get(
          'https://api.themoviedb.org/3/movie/$id?language=en-US',
          options: _options);

      return Result.success([Movie.fromJSON(response.data)]);
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  @override
  Future<Result<List<Movie>>> getNowPlaying({int page = 1}) async =>
      _getMovies(_MovieCategory.nowPlaying.toString(), page: page);

  @override
  Future<Result<List<Movie>>> getUpcoming({int page = 1}) async =>
      _getMovies(_MovieCategory.upcoming.toString(), page: page);

  Future<Result<List<Movie>>> _getMovies(String category,
      {int page = 1}) async {
    try {
      final response = await dio!.get(
          'https://api.themoviedb.org/3/movie/$category?language=en-US&page=$page',
          options: _options);

      final result = List<Map<String, dynamic>>.from(response.data['results']);

      return Result.success(result.map((e) => Movie.fromJSON(e)).toList());
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }
}

enum _MovieCategory {
  nowPlaying('now_playing'),
  upcoming('upcoming');

  final String _instring;

  const _MovieCategory(String instring) : _instring = instring;

  @override
  String toString() => _instring;
}
