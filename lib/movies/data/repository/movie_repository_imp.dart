import 'package:second_task_cleancode/core/error/exceptions.dart';
import 'package:second_task_cleancode/core/error/failures.dart';
import 'package:second_task_cleancode/core/network/movie_constants.dart';
import 'package:second_task_cleancode/movies/data/datasource/movie_remote_datasource.dart';
import 'package:second_task_cleancode/movies/data/models/movie_model.dart';
import 'package:second_task_cleancode/movies/domain/repository/base_movie_repository.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImp extends BaseMovieRepository {
  final MovieRemoteDataSource _movieRemoteDataSource;

  MovieRepositoryImp(this._movieRemoteDataSource);

  @override
  Future<Either<Failure, List<MovieModel>>> getNowPlayingMovies() async {
    try {
      List<MovieModel> movies =
          await _movieRemoteDataSource.getNowPlayingMovies(
        endPoint: MovieConstants.moviePlayingNowEndPoint,
        parameter: {
          'api_key':MovieConstants.movieAPIKey,
        },

      );
      return Right(movies);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.errorMessageModel.message),
      );
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getPopularMovies() async {
    try {
      List<MovieModel> movies =
          await _movieRemoteDataSource.getPopularMovies(
        endPoint: MovieConstants.moviePopularEndPoint,
        parameter: {
          'api_key':MovieConstants.movieAPIKey,
        },

      );
      return Right(movies);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.errorMessageModel.message),
      );
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getTopRatedMovies() async {
    try {
      List<MovieModel> movies =
          await _movieRemoteDataSource.getTopRatedMovies(
        endPoint: MovieConstants.movieTopRatedEndPoint,
        parameter: {
          'api_key':MovieConstants.movieAPIKey,
        },

      );
      return Right(movies);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.errorMessageModel.message),
      );
    }
  }
}
