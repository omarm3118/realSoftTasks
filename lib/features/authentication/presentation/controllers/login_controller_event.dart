part of 'login_controller_bloc.dart';


abstract class LoginControllerEvent extends Equatable {
}


class LoginWithEmailAndPasswordEvent extends LoginControllerEvent {
  final String? email;
  final String? password;

  LoginWithEmailAndPasswordEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email??'', password??''];

}