part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetNowPlayingMoviesEvent extends MovieEvent{}
class GetTopRatedMoviesEvent extends MovieEvent{}
class GetPopularMoviesEvent extends MovieEvent{}
