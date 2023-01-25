import 'package:chat_app/core/util/app_constants.dart';
import 'package:chat_app/core/util/conditional_builder.dart';
import 'package:chat_app/features/chats/domain/entites/user_entity.dart';
import 'package:chat_app/features/chats/presentation/controllers/dashboard_bloc.dart';
import 'package:chat_app/features/chats/presentation/pages/chatting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/presentation/pages/login_page.dart';

class DashBoardPage extends StatelessWidget {
  static const String route = 'DashBoardPage';

  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<UserEntity>? users;
    UserEntity? user;
    DashboardBloc bloc = DashboardBloc.get(context)
      ..add(GetUserInfoEvent())
      ..add(GetAllUsersEvent());
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {
        if (state is GetAllUsersSuccessState) {
          users = state.users;
        }
        if (state is GetUserInfoSuccessState) {
          user = state.user;
        }
        if (state is SignOutSuccessState) {
          Navigator.pushReplacementNamed(context, LoginPage.route);
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          successWidget: (_) => Scaffold(
            backgroundColor: AppConstants.scaffoldBackgroundColor,
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Hello',
                style: TextStyle(
                    color: AppConstants.defaultPurple,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
            ),
            body: DashBoardBody(users: users, user: user),
            floatingActionButton: (state is SignOutLoadingState)
                ? const CircularProgressIndicator()
                : FloatingActionButton.extended(
                    onPressed: () {
                      bloc.add(SignOutDashBoardEvent());
                    },
                    label: const Text('SignOut'),
                    icon: const Icon(Icons.logout_outlined),
                  ),
          ),
          fallbackWidget: (_) => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          condition: user != null && users != null,
        );
      },
    );
  }
}

class DashBoardBody extends StatelessWidget {
  const DashBoardBody({
    Key? key,
    required this.users,
    required this.user,
  }) : super(key: key);

  final List<UserEntity>? users;
  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (ctx, index) {
          if (users?[index].id == user?.id) {
            return const SizedBox();
          }
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, ChattingPage.route,
                  arguments: {'me': user, 'to': users?[index]});
            },
            leading: avatarColor(
                color: AppConstants.userColors[users![index].colorIndex]),
            title: Text(users![index].userName),
            subtitle: Text(users![index].email),
          );
        },
        separatorBuilder: (ctx, index) {
          if (users?[index].id == user?.id) {
            return const SizedBox();
          }
          return const Divider(
            indent: 20,
          );
        },
        itemCount: users!.length);
  }
}

SizedBox avatarColor({
  required Color color,
}) {
  return SizedBox(
    height: 50,
    width: 50,
    child: Card(
      shape: const CircleBorder(),
      color: color,
      elevation: 10,
      shadowColor: color,
    ),
  );
}
