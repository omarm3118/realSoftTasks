import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_task_cleancode/movies/domain/entities/movie_entity.dart';
import 'package:second_task_cleancode/movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:second_task_cleancode/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:second_task_cleancode/movies/domain/usecases/get_toprated_movies_usecase.dart';

import '../../../core/error/failures.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  GetPopularMoviesUseCase getPopularMoviesUseCase;
  GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;

  MovieBloc(this.getNowPlayingMoviesUseCase, this.getTopRatedMoviesUseCase,
      this.getPopularMoviesUseCase)
      : super(InitState()) {
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);
    on<GetPopularMoviesEvent>(_getPopularMovies);
    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
  }

  static MovieBloc get(BuildContext ctx) => BlocProvider.of<MovieBloc>(ctx);

  _getNowPlayingMovies(event, emit) async {
    emit(_chooseMovieTypeLoading(MoviesType.nowPlaying));
    Either<Failure, List<MovieEntity>> result =
        await getNowPlayingMoviesUseCase();
    _eitherSuccessOrErrorState(result, emit, MoviesType.nowPlaying);
  }

  _getPopularMovies(event, emit) async {
    emit(_chooseMovieTypeLoading(MoviesType.popular));
    Either<Failure, List<MovieEntity>> result =
        await getPopularMoviesUseCase();
    _eitherSuccessOrErrorState(result, emit, MoviesType.popular);
  }

  _getTopRatedMovies(event, emit) async {
    emit(_chooseMovieTypeLoading(MoviesType.topRated));
    Either<Failure, List<MovieEntity>> result =
        await getTopRatedMoviesUseCase();
    _eitherSuccessOrErrorState(result, emit, MoviesType.topRated);
  }

  _eitherSuccessOrErrorState(
      Either<Failure, List<MovieEntity>> result, emit, moviesType) {
    result.fold(
        (Failure failure) =>
            emit(_chooseMovieTypeError(failure.message, moviesType)),
        (List<MovieEntity> movies) =>
            emit(_chooseMovieTypeSuccess(movies, moviesType)));
  }

  _chooseMovieTypeLoading(
    MoviesType moviesType,
  ) {
    switch (moviesType) {
      case MoviesType.popular:
        return PopularMovieLoadingState();
      case MoviesType.topRated:
        return TopRatedMovieLoadingState();
      case MoviesType.nowPlaying:
        return PlayingNowMovieLoadingState();
    }
  }

  _chooseMovieTypeSuccess(
    List<MovieEntity> movies,
    MoviesType moviesType,
  ) {
    switch (moviesType) {
      case MoviesType.popular:
        return PopularMovieSuccessState(popularMovies: movies);
      case MoviesType.topRated:
        return TopRatedMovieSuccessState(topRatedMovies: movies);
      case MoviesType.nowPlaying:
        return PlayingNowMovieSuccessState(nowPlayingMovies: movies);
    }
  }

  _chooseMovieTypeError(
    String errorMessage,
    MoviesType moviesType,
  ) {
    switch (moviesType) {
      case MoviesType.popular:
        return PopularMovieErrorState(errorMessage: errorMessage);
      case MoviesType.topRated:
        return TopRatedMovieErrorState(errorMessage: errorMessage);
      case MoviesType.nowPlaying:
        return PlayingNowMovieErrorState(errorMessage: errorMessage);
    }
  }
}
