import 'package:chat_app/features/authentication/presentation/controllers/login_controller_bloc.dart';
import 'package:chat_app/features/authentication/presentation/controllers/sign_up_bloc.dart';
import 'package:chat_app/features/authentication/presentation/pages/login_page.dart';
import 'package:chat_app/features/authentication/presentation/pages/sign_up_page.dart';
import 'package:chat_app/features/chats/domain/entites/user_entity.dart';
import 'package:chat_app/features/chats/presentation/controllers/chatting_bloc.dart';
import 'package:chat_app/features/chats/presentation/pages/chatting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/service_locator.dart';
import 'features/chats/presentation/controllers/dashboard_bloc.dart';
import 'features/chats/presentation/pages/dashboard_page.dart';

class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    logInRoute() {
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => sl<LoginControllerBloc>(),
          child: const LoginPage(),
        ),
      );
    }

    switch (settings.name) {
      case LoginPage.route:
        return logInRoute();
      case SignUpPage.route:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<SignUpBloc>(),
            child: const SignUpPage(),
          ),
        );
      case ChattingPage.route:
        Map args = settings.arguments as Map;
        UserEntity me = args['me'];
        UserEntity to = args['to'];
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<ChattingBloc>(),
                  child: ChattingPage(
                    me: me,
                    to: to,
                  ),
                ));
      case DashBoardPage.route:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => sl<DashboardBloc>()
                    ..add(GetAllUsersEvent())
                    ..add(GetUserInfoEvent()),
                  child: const DashBoardPage(),
                ));

      default:
        return logInRoute();
    }
  }
}
