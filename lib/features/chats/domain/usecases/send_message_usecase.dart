import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/chat_model.dart';
import '../repository/base_chatting_repository.dart';

class SendMessageUseCase extends BaseUseCase<void, MessageParam> {
  final BaseChattingRepository _repository;

  SendMessageUseCase(this._repository);
  @override
  Future<Either<Failure, void>> call(MessageParam param) async {
    return await _repository.sendMessage(messageParam: param);
  }
}

class MessageParam extends Equatable {
  final String senderId;
  final String receiverId;
  final ChatModel chatEntity;

  const MessageParam(this.senderId, this.receiverId, this.chatEntity);

  @override
  List<Object> get props => [senderId, receiverId, chatEntity];
}
