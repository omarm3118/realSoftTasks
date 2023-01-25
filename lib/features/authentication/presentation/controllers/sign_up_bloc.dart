import 'package:chat_app/core/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../chats/domain/usecases/insert_user_data_usecase.dart';
import '../../data/models/user_auth_model.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;
  final InsertUserDataUseCase _insertUserUseCase;

  SignUpBloc(this._signUpUseCase, this._signOutUseCase, this._insertUserUseCase)
      : super(SignUpInitial()) {
    on<SignUpWithEmailAndPasswordEvent>(_signUpEvent);
    on<SignOutEvent>(_signOutEvent);
      }

  final GlobalKey<FormState> getFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  int currentIndex = 0;

  changeAvatarColor(int index) {
    currentIndex = index;
    emit(ChangeAvatarColor());
  }

  static SignUpBloc get(context) => BlocProvider.of<SignUpBloc>(context);

  _signUpEvent(SignUpWithEmailAndPasswordEvent event, Emitter emit) async {
    if (checkValidation()) {
      emit(SignUpLoadingState());
      Either<Failure, UserAuthModel> result =
          await _signUpUseCase(UserAuthParam(event.email, event.password));
      result.fold(
        (l) => emit(SignUpErrorState(message: l.message)),
        (r) async {
          _ifAuthSuccessInsertDataIntoDB(r);
        },
      );
    }
  }

  _ifAuthSuccessInsertDataIntoDB(r) async {
    Either<Failure, void> either = await _insertUserUseCase.call(
        UserInfoParam(userNameController.text, r.id, currentIndex, r.email));
    either.fold((lInner) => emit(SignUpErrorState(message: lInner.message)),
        (rInner) => emit(SignUpSuccessState(email: r.email, id: r.id)));
  }

  _signOutEvent(SignOutEvent event, Emitter emit) async {
    Either<Failure, void> result = await _signOutUseCase(NoParam());
    result.fold(
      (l) => emit(SignOutErrorState()),
      (r) => emit(SignOutSuccessState()),
    );
  }

  checkValidation() {
    return getFormKey.currentState!.validate();
  }
}
