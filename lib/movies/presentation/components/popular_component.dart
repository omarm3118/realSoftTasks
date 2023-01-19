import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_task_cleancode/core/network/movie_constants.dart';

import '../../domain/entities/movie_entity.dart';
import '../controller/movie_bloc.dart';
import 'error_compnent.dart';
import 'loading_component.dart';

class PopularMovies extends StatelessWidget {
  const PopularMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovieBloc.get(context).add(GetPopularMoviesEvent());
    return BlocBuilder<MovieBloc, MovieState>(
      buildWhen: (preState, curState) {
        if (curState is PopularMovieLoadingState ||
            curState is PopularMovieSuccessState ||
            curState is PopularMovieErrorState) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        List<MovieEntity> movies = [];
        switch (state.runtimeType) {
          case PopularMovieSuccessState:
            state as PopularMovieSuccessState;
            movies = state.popularMovies!;
            return successWidget(movies);
          case PopularMovieErrorState:
            state as PopularMovieErrorState;
            return SizedBox(
              height: 100,
              child: MyErrorWidget(
                errorMessage: state.errorMessage!,
              ),
            );
          default:
            return const SizedBox(height: 100,child: LoadingWidget());
        }
      },
    );
  }

  Widget successWidget(List<MovieEntity> movies) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return SizedBox(
            width: 80,
            height: 100,
            child: Card(              clipBehavior: Clip.antiAlias,


              child: Image(
                image: NetworkImage(
                  MovieConstants.concatenateImageURL(
                    movies[index].imageUrl,
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        itemCount: movies.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 10,
          );
        },
      ),
    );
  }
}
