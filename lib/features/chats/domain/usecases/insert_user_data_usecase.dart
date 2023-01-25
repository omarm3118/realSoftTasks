import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/usecase/base_usecase.dart';
import 'package:chat_app/features/chats/domain/repository/base_chatting_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class InsertUserDataUseCase extends BaseUseCase<void,UserInfoParam> {

  final BaseChattingRepository _repository;

  InsertUserDataUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(UserInfoParam param) async {
    return await _repository.insertUserDataIntoDB(userInfoParam: param);
  }

}

class UserInfoParam extends Equatable {
  final String userName;
  final String userId;
  final String email;
  final int avatarColor;

  const UserInfoParam(this.userName, this.userId, this.avatarColor, this.email);

  @override
  List<Object> get props => [userName, userId, avatarColor,email];
}