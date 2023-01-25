import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/authentication/data/models/user_auth_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login_usecase.dart';

part 'login_controller_event.dart';

part 'login_controller_state.dart';

class LoginControllerBloc
    extends Bloc<LoginControllerEvent, LoginControllerState> {
  final LoginUseCase _loginUseCase;

  LoginControllerBloc(this._loginUseCase) : super(LoginControllerInitial()) {
    on<LoginWithEmailAndPasswordEvent>(_loginEvent);
  }

  final GlobalKey<FormState> getFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  static LoginControllerBloc get(context) =>
      BlocProvider.of<LoginControllerBloc>(context);

  _loginEvent(LoginWithEmailAndPasswordEvent event, Emitter emit) async {
    if (checkValidation()) {
      emit(LoginLoadingState());
      Either<Failure, UserAuthModel> result =
          await _loginUseCase(UserAuthParam(event.email!, event.password!));
      result.fold(
        (l) => emit(LoginErrorState(message: l.message)),
        (r) => emit(LoginSuccessState(email: r.email, id: r.id)),
      );
    }
  }

  checkValidation() {
    return getFormKey.currentState!.validate();
  }
}
