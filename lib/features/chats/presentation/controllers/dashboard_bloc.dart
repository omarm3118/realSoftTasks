import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/usecase/base_usecase.dart';
import 'package:chat_app/features/chats/domain/entites/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_all_users_usecase.dart';
import '../../domain/usecases/get_user_info_usecase.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetAllUsersUseCase _getAllUsersUseCase;
  final GetUserInfoUseCase _getUserInfoUseCase;

  DashboardBloc(
    this._getAllUsersUseCase,
    this._getUserInfoUseCase,
  ) : super(DashboardInitial()) {
    on<GetAllUsersEvent>(_getAllUsers);
    on<GetUserInfoEvent>(_getUserInfo);
    on<SignOutDashBoardEvent>(_signOut);
  }

  static DashboardBloc get(context) => BlocProvider.of<DashboardBloc>(context);

  _getAllUsers(event, emit) async {
    emit(GetAllUsersLoadingState());
    Either<Failure, List<UserEntity>> result =
        await _getAllUsersUseCase.call(NoParam());
    result.fold((Failure l) => emit(GetAllUsersErrorState(l.message)),
        (List<UserEntity> r) => emit(GetAllUsersSuccessState(r)));
  }

  _getUserInfo(GetUserInfoEvent event, Emitter<DashboardState> emit) async {
    Either<Failure, UserEntity> result =
        await _getUserInfoUseCase.call(NoParam());
    result.fold(
      (l) => emit(GetUserInfoErrorState(l.message)),
      (r) => emit(GetUserInfoSuccessState(r)),
    );
  }

  _signOut(SignOutDashBoardEvent event, Emitter<DashboardState> emit) async {
    emit(SignOutLoadingState());
    await FirebaseAuth.instance.signOut().then((value) {
      emit(SignOutSuccessState());
    }).catchError((error) {
      emit(SignOutErrorState());
    });
  }
}
