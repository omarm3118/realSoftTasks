import 'package:equatable/equatable.dart';

class UserAuthEntity extends Equatable {

  final String email;
  final String id;

  const UserAuthEntity(this.email, this.id);

  @override
  List<Object> get props => [email, id];


}