import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_task_cleancode/movies/presentation/controller/movie_bloc.dart';
import 'package:second_task_cleancode/movies/presentation/pages/movie_home_page.dart';

import 'core/services/service_locator.dart';

class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MovieHomePage.route:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (ctx) => MovieBloc(s1(), s1(), s1())
              ..add(GetNowPlayingMoviesEvent())
              ..add(GetTopRatedMoviesEvent())
              ..add(GetPopularMoviesEvent()),
            child: const MovieHomePage(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (ctx) => MovieBloc(s1(), s1(), s1())
              ..add(GetNowPlayingMoviesEvent())
              ..add(GetTopRatedMoviesEvent())
              ..add(GetPopularMoviesEvent()),
            child: const MovieHomePage(),
          ),
        );
    }
  }
}
