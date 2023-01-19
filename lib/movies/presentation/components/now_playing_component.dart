import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_task_cleancode/movies/presentation/components/error_compnent.dart';
import 'package:second_task_cleancode/movies/presentation/controller/movie_bloc.dart';

import '../../../core/network/movie_constants.dart';
import '../../domain/entities/movie_entity.dart';
import 'loading_component.dart';

class NowPlayingMovies extends StatelessWidget {
  const NowPlayingMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovieBloc.get(context).add(GetNowPlayingMoviesEvent());
    return BlocBuilder<MovieBloc, MovieState>(
      buildWhen: (preState, curState) {
        if (curState is PlayingNowMovieErrorState ||
            curState is PlayingNowMovieLoadingState ||
            curState is PlayingNowMovieSuccessState) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        List<MovieEntity> movies = [];
        switch (state.runtimeType) {
          case PlayingNowMovieSuccessState:
            state as PlayingNowMovieSuccessState;
            movies = state.nowPlayingMovies!;
            return successWidget(movies);
          case PlayingNowMovieErrorState:
            state as PlayingNowMovieErrorState;
            return SizedBox(
              height: 400,
              child: MyErrorWidget(
                errorMessage: state.errorMessage!,
              ),
            );
          default:
            return const SizedBox(height:400,child: LoadingWidget());
        }
      },
    );
  }

  SizedBox successWidget(List<MovieEntity> movies) {
    return SizedBox(
      height: 400,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) => Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              MovieConstants.concatenateImageURL(
                movies[index].imageUrl,
              ),
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.circle,
                        size: 20,
                        color: Colors.redAccent,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Now Playing',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                    color: Colors.red.withOpacity(0.5),
                    alignment: Alignment.center,
                    child: Text(
                      movies[index].title,
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        itemCount: movies.length,
      ),
    );
  }
}
