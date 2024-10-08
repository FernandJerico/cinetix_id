import 'package:cinetix_id/data/repositories/movie_repository.dart';
import 'package:cinetix_id/domain/entities/actor.dart';
import 'package:cinetix_id/domain/entities/result.dart';
import 'package:cinetix_id/domain/usecases/get_actors/get_actors_param.dart';
import 'package:cinetix_id/domain/usecases/usecase.dart';

class GetActors implements UseCase<Result<List<Actor>>, GetActorsParam> {
  final MovieRepository _movieRepository;

  GetActors({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;
  @override
  Future<Result<List<Actor>>> call(GetActorsParam params) async {
    var actorsResult = await _movieRepository.getActors(id: params.movieId);
    return switch (actorsResult) {
      Success(data: final actors) => Result.success(actors),
      Failed(:final message) => Result.failed(message)
    };
  }
}
