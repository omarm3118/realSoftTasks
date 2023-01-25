part of 'dashboard_bloc.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class GetAllUsersLoadingState extends DashboardState {}

class GetAllUsersErrorState extends DashboardState {
  final String message;

  GetAllUsersErrorState(this.message);
}

class GetAllUsersSuccessState extends DashboardState {
  final List<UserEntity> users;

  GetAllUsersSuccessState(this.users);
}

class GetUserInfoSuccessState extends DashboardState {
  final UserEntity user;

  GetUserInfoSuccessState(this.user);
}
class GetUserInfoLoadingState extends DashboardState{}
class GetUserInfoErrorState extends DashboardState {
  final String message;

  GetUserInfoErrorState(this.message);
}

class SignOutLoadingState extends DashboardState{}
class SignOutSuccessState extends DashboardState{}
class SignOutErrorState extends DashboardState{}

