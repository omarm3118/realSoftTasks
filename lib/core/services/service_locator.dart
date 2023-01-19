import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:second_task_cleancode/core/network/movie_constants.dart';
import 'package:second_task_cleancode/movies/data/datasource/movie_remote_datasource.dart';
import 'package:second_task_cleancode/movies/data/repository/movie_repository_imp.dart';
import 'package:second_task_cleancode/movies/domain/repository/base_movie_repository.dart';
import 'package:second_task_cleancode/movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:second_task_cleancode/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:second_task_cleancode/movies/domain/usecases/get_toprated_movies_usecase.dart';

GetIt s1 = GetIt.instance;

class ServiceLocator {
  static init() {
    s1.registerLazySingleton<BaseMovieRepository>(
        () => MovieRepositoryImp(s1()));
    s1.registerLazySingleton<MovieRemoteDataSource>(
        () => MovieRemoteDataSource(s1()));
    s1.registerLazySingleton<Dio>(
        () => Dio(BaseOptions(baseUrl: MovieConstants.movieBaseUrl)));
    s1.registerLazySingleton<GetNowPlayingMoviesUseCase>(
        () => GetNowPlayingMoviesUseCase(s1()));
    s1.registerLazySingleton<GetPopularMoviesUseCase>(
        () => GetPopularMoviesUseCase(s1()));
    s1.registerLazySingleton<GetTopRatedMoviesUseCase>(
        () => GetTopRatedMoviesUseCase(s1()));
  }
}
















