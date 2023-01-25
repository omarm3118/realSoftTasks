import 'package:chat_app/features/chats/domain/entites/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required super.userName,
      required super.id,
      required super.colorIndex,
      required super.email});

  factory UserModel.fromJson({required Map<String, dynamic> data}) {
    return UserModel(
        userName: data['userName'],
        id: data['userId'],
        colorIndex: data['avatarColor'],
        email: data['email']);
  }
}
