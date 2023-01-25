part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {}

class SignUpWithEmailAndPasswordEvent extends SignUpEvent {
  final String email;
  final String password;

  SignUpWithEmailAndPasswordEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];

}


class SignOutEvent extends SignUpEvent{
  @override
  List<Object?> get props => [];
}