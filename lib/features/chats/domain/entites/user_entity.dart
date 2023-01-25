import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userName;
  final String id;
  final int colorIndex;
  final String email;

  const UserEntity(
      {required this.userName,
      required this.id,
      required,
      required this.colorIndex,
      required this.email});

  @override
  List<Object> get props => [userName, id, colorIndex, email];
}
