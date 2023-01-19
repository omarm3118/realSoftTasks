import 'package:dartz/dartz.dart';
import 'package:second_task_cleancode/core/error/failures.dart';
import 'package:second_task_cleancode/core/usecase/base_usecase.dart';
import 'package:second_task_cleancode/movies/data/models/movie_model.dart';
import 'package:second_task_cleancode/movies/domain/repository/base_movie_repository.dart';

class GetNowPlayingMoviesUseCase extends BaseUseCase<List<MovieModel>> {
  final BaseMovieRepository _baseMovieRepository;

  GetNowPlayingMoviesUseCase(this._baseMovieRepository);

  @override
  Future<Either<Failure, List<MovieModel>>> call() async {
    return await _baseMovieRepository.getNowPlayingMovies();
  }
}
