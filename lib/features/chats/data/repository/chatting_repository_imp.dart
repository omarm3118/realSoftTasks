import 'package:chat_app/core/error/exceptions.dart';
import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/chats/data/datasource/firestore_db_remote.dart';
import 'package:chat_app/features/chats/data/models/user_model.dart';
import 'package:chat_app/features/chats/domain/entites/user_entity.dart';
import 'package:chat_app/features/chats/domain/repository/base_chatting_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../domain/usecases/get_messages_usecase.dart';
import '../../domain/usecases/insert_user_data_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';

class ChattingRepositoryImp extends BaseChattingRepository {
  final BaseDBRemote _baseDBRemote;

  ChattingRepositoryImp(this._baseDBRemote);

  @override
  Future<Either<Failure, UserEntity>> getUserInfo() async {
    try {
      UserModel user = await _baseDBRemote.getUserInfo();
      return right(user);
    } on ServerException catch (error) {
      return left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, void>> insertUserDataIntoDB(
      {required UserInfoParam userInfoParam}) async {
    try {
      _baseDBRemote.insertUserData(
          userName: userInfoParam.userName,
          avatarColor: userInfoParam.avatarColor,
          userId: userInfoParam.userId,
          email: userInfoParam.email);
      return right(null);
    } on ServerException catch (error) {
      return left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      List<UserModel> users = await _baseDBRemote.getAllUsers();
      return right(users);
    } on ServerException catch (error) {
      return left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage(
      {required MessageParam messageParam}) async {
    try {
      await _baseDBRemote.sendMessage(
          senderId: messageParam.senderId,
          receiverId: messageParam.receiverId,
          data: messageParam.chatEntity);
      return right(null);
    } on ServerException catch (error) {
      return left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Either<Failure, Stream<QuerySnapshot<Map<String,dynamic>>>> getMessages({
    required GetMessagesParam param,
  }) {
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> stream =
          _baseDBRemote.getAllMessages(
              senderId: param.senderId, receiverId: param.receiverId);

      return right(stream);
    } on ServerException catch (error) {
      return left(ServerFailure(error.errorMessageModel.message));
    }
  }
}
