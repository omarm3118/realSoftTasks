import 'package:chat_app/features/authentication/data/datasource/firebase_auth_remote.dart';
import 'package:chat_app/features/authentication/data/repository/auth_repository_imp.dart';
import 'package:chat_app/features/authentication/domain/usecases/get_current_user_usecase.dart';
import 'package:chat_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:chat_app/features/authentication/domain/usecases/sign_out_usecase.dart';
import 'package:chat_app/features/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:chat_app/features/authentication/presentation/controllers/login_controller_bloc.dart';
import 'package:chat_app/features/authentication/presentation/controllers/sign_up_bloc.dart';
import 'package:chat_app/features/chats/data/datasource/firestore_db_remote.dart';
import 'package:chat_app/features/chats/data/repository/chatting_repository_imp.dart';
import 'package:chat_app/features/chats/domain/repository/base_chatting_repository.dart';
import 'package:chat_app/features/chats/domain/usecases/get_messages_usecase.dart';
import 'package:chat_app/features/chats/domain/usecases/get_user_info_usecase.dart';
import 'package:chat_app/features/chats/domain/usecases/insert_user_data_usecase.dart';
import 'package:chat_app/features/chats/presentation/controllers/chatting_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/chats/domain/usecases/get_all_users_usecase.dart';
import '../../features/chats/domain/usecases/send_message_usecase.dart';
import '../../features/chats/presentation/controllers/dashboard_bloc.dart';

GetIt sl = GetIt.instance;

class ServiceLocator {
  static init() {
    sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    sl.registerLazySingleton<AuthRemote>(
        () => AuthRemote(firebaseAuth: sl<FirebaseAuth>()));
    sl.registerLazySingleton<AuthRepoImp>(() => AuthRepoImp(sl<AuthRemote>()));

    sl.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(sl<AuthRepoImp>()));
    sl.registerLazySingleton<SignOutUseCase>(
        () => SignOutUseCase(sl<AuthRepoImp>()));
    sl.registerLazySingleton<SignUpUseCase>(
        () => SignUpUseCase(sl<AuthRepoImp>()));
    sl.registerLazySingleton<GetCurrentUserUseCase>(
        () => GetCurrentUserUseCase(sl<AuthRepoImp>()));

    sl.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance);
    sl.registerLazySingleton<DBRemote>(
        () => DBRemote(sl<FirebaseFirestore>()));
    sl.registerLazySingleton<ChattingRepositoryImp>(
        () => ChattingRepositoryImp(sl<DBRemote>()));
    sl.registerLazySingleton<InsertUserDataUseCase>(
        () => InsertUserDataUseCase(sl<ChattingRepositoryImp>()));
    sl.registerLazySingleton<GetAllUsersUseCase>(
        () => GetAllUsersUseCase(sl<ChattingRepositoryImp>()));
    sl.registerLazySingleton<GetUserInfoUseCase>(
        () => GetUserInfoUseCase(sl<ChattingRepositoryImp>()));
    sl.registerLazySingleton<SendMessageUseCase>(
        () => SendMessageUseCase(sl<ChattingRepositoryImp>()));
    sl.registerLazySingleton<GetMessagesUseCase>(
        () => GetMessagesUseCase(sl<ChattingRepositoryImp>()));


    sl.registerFactory<LoginControllerBloc>(
        () => LoginControllerBloc(sl<LoginUseCase>()));
    sl.registerFactory<SignUpBloc>(() => SignUpBloc(sl<SignUpUseCase>(),
        sl<SignOutUseCase>(), sl<InsertUserDataUseCase>()));
    sl.registerFactory<DashboardBloc>(() =>
        DashboardBloc(sl<GetAllUsersUseCase>(), sl<GetUserInfoUseCase>()));
    sl.registerFactory<ChattingBloc>(
        () => ChattingBloc(sl<SendMessageUseCase>(), sl<GetMessagesUseCase>()));
  }
}
