import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/usecase/base_usecase.dart';
import 'package:chat_app/features/chats/data/repository/chatting_repository_imp.dart';
import 'package:chat_app/features/chats/domain/entites/user_entity.dart';
import 'package:dartz/dartz.dart';

class GetUserInfoUseCase extends BaseUseCase<UserEntity, NoParam> {
  final ChattingRepositoryImp _chattingRepositoryImp;

  GetUserInfoUseCase(this._chattingRepositoryImp);

  @override
  Future<Either<Failure, UserEntity>> call(NoParam param) async {
    return await _chattingRepositoryImp.getUserInfo();
  }
}
