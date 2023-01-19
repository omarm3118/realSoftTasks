


import 'package:dartz/dartz.dart';
import 'package:second_task_cleancode/core/error/failures.dart';
import '../../data/models/movie_model.dart';

abstract class BaseMovieRepository {
   Future<Either<Failure, List<MovieModel>>>  getNowPlayingMovies();
   Future<Either<Failure, List<MovieModel>>>  getTopRatedMovies();
   Future<Either<Failure, List<MovieModel>>>  getPopularMovies();
}
