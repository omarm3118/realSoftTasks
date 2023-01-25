import 'package:chat_app/features/chats/domain/entites/chat_entity.dart';

class ChatModel extends ChatEntity {
   ChatModel(
      {required super.messageDate,
      required super.senderId,
      required super.receiverId,
      required super.message,
       super.messageId});

  factory ChatModel.fromJson({required Map<String, dynamic> data}) {
    return ChatModel(
        messageDate: data['messageDate'],
        senderId: data['senderId'],
        receiverId: data['receiverId'],
        message: data['message'],
        messageId: data['messageId']);
  }

  Map<String,dynamic>toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'messageDate':messageDate,
    };
  }
}
