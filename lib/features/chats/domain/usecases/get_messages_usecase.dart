import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/chats/domain/repository/base_chatting_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/base_usecase.dart';

class GetMessagesUseCase extends BaseUseCase<Stream<QuerySnapshot>, GetMessagesParam> {
  final BaseChattingRepository _repository;

  GetMessagesUseCase(this._repository);

  @override
  Future<Either<Failure, Stream<QuerySnapshot>>> call(GetMessagesParam param) async {
    return _repository.getMessages(param: param);
  }
}

class GetMessagesParam extends Equatable {
  final String senderId;
  final String receiverId;

  const GetMessagesParam(this.senderId, this.receiverId);

  @override
  List<Object> get props => [senderId, receiverId];
}
