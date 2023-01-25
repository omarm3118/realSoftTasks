part of 'chatting_bloc.dart';


abstract class ChattingState {}

class ChattingInitial extends ChattingState {}

class GetAllMessagesLoadingState extends ChattingState {}
class GetAllMessagesSuccessState extends ChattingState {
  final List<ChatModel> chats;

  GetAllMessagesSuccessState(this.chats);
}
class GetAllMessagesErrorState extends ChattingState {
  final String message;

  GetAllMessagesErrorState(this.message);
}

class SendAMessageLoadingState extends ChattingState{}
class SendAMessageSuccessState extends ChattingState {}
class SendAMessageErrorState extends ChattingState {
  final String message;

  SendAMessageErrorState(this.message);
}
