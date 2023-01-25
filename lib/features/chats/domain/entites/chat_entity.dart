import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String messageDate;
  final String senderId;
  final String receiverId;
  final String message;
   String? messageId;

   ChatEntity({
    required this.messageDate,
    required this.senderId,
    required this.receiverId,
    required this.message,
     this.messageId,
  });

  @override
  List<Object> get props => [
        messageDate,
        senderId,
        receiverId,
        message,
        messageId??'',
      ];
}
