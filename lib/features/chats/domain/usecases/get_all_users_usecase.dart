import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/usecase/base_usecase.dart';
import 'package:chat_app/features/chats/domain/entites/user_entity.dart';
import 'package:chat_app/features/chats/domain/repository/base_chatting_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllUsersUseCase extends BaseUseCase<List<UserEntity>,NoParam>
{
  final BaseChattingRepository _baseChattingRepository;

  GetAllUsersUseCase(this._baseChattingRepository);
  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParam param) {
    return _baseChattingRepository.getAllUsers();
  }
}