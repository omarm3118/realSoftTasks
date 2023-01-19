import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_task_cleancode/movies/presentation/components/popular_component.dart';

import 'package:second_task_cleancode/movies/presentation/controller/movie_bloc.dart';

import '../components/now_playing_component.dart';
import '../components/top_rated_component.dart';

class MovieHomePage extends StatelessWidget {
  static const route = '/';

  const MovieHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff232323),
      body: SafeArea(
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (ctx, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  NowPlayingMovies(),
                  SizedBox(height: 10,),
                  Text(
                    'TopRated Movies',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  TopRatedMovies(),
                  Text(
                    'Popular',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  PopularMovies(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
