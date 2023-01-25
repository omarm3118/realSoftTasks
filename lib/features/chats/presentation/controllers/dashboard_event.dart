part of 'dashboard_bloc.dart';


abstract class DashboardEvent {}

class GetAllUsersEvent extends DashboardEvent{}
class GetUserInfoEvent extends DashboardEvent{}
class SignOutDashBoardEvent extends DashboardEvent{}