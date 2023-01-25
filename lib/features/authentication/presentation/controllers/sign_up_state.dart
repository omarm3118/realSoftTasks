part of 'sign_up_bloc.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {
  final String email;
  final String id;

  SignUpSuccessState({required this.email, required this.id});
}

class SignUpErrorState extends SignUpState {
  final String message;

  SignUpErrorState({required this.message});
}

class SignOutSuccessState extends SignUpState {}

class SignOutErrorState extends SignUpState {}

class ChangeAvatarColor extends SignUpState{}
