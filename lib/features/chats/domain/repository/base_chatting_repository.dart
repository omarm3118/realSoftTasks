import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/chats/domain/entites/user_entity.dart';
import 'package:chat_app/features/chats/domain/usecases/get_messages_usecase.dart';
import 'package:chat_app/features/chats/domain/usecases/insert_user_data_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../usecases/send_message_usecase.dart';

abstract class BaseChattingRepository {
  Future<Either<Failure, List<UserEntity>>> getAllUsers();

  Either<Failure,Stream<QuerySnapshot>> getMessages({required GetMessagesParam param});

  Future<Either<Failure,void>> sendMessage({required MessageParam messageParam});

  Future<Either<Failure, UserEntity>> getUserInfo();

  Future<Either<Failure, void>> insertUserDataIntoDB(
      {required UserInfoParam userInfoParam});

}
