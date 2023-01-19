part of 'movie_bloc.dart';

enum MoviesType { popular, nowPlaying, topRated }

abstract class MovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitState extends MovieState {}

class PlayingNowMovieLoadingState extends MovieState {}

class PlayingNowMovieSuccessState extends MovieState {

  final List<MovieEntity>? nowPlayingMovies;
  PlayingNowMovieSuccessState(
      {required this.nowPlayingMovies}) ;
  }

class PlayingNowMovieErrorState extends MovieState {
  final String? errorMessage;

  PlayingNowMovieErrorState({required this.errorMessage});
}



class TopRatedMovieLoadingState extends MovieState {}

class TopRatedMovieSuccessState extends MovieState {

 final List<MovieEntity>? topRatedMovies;
  TopRatedMovieSuccessState(
      {required this.topRatedMovies}) ;
}

class TopRatedMovieErrorState extends MovieState {
  final String? errorMessage;

  TopRatedMovieErrorState({required this.errorMessage});
}



class PopularMovieLoadingState extends MovieState {}

class PopularMovieSuccessState extends MovieState {

  final List<MovieEntity>? popularMovies;
  PopularMovieSuccessState(
      {required this.popularMovies}) ;
}

class PopularMovieErrorState extends MovieState {
  final String? errorMessage;

  PopularMovieErrorState({required this.errorMessage});
}
