part of 'chatting_bloc.dart';

abstract class ChattingEvent {}

class SendAMessageEvent extends ChattingEvent{
  final String senderId;
  final String receiverId;

  SendAMessageEvent(this.senderId, this.receiverId);
}
class GetAllMessages extends ChattingEvent{
  final String senderId;
  final String receiverId;

  GetAllMessages(this.senderId, this.receiverId);
}