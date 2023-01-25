part of 'login_controller_bloc.dart';

abstract class LoginControllerState {}

class LoginControllerInitial extends LoginControllerState {}

class LoginLoadingState extends LoginControllerState {}

class LoginSuccessState extends LoginControllerState {
  final String email;
  final String id;

  LoginSuccessState({required this.email, required this.id});
}

class LoginErrorState extends LoginControllerState {
  final String message;

  LoginErrorState({required this.message}) ;
}
