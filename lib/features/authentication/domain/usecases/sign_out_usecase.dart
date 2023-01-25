import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/usecase/base_usecase.dart';
import 'package:chat_app/features/authentication/domain/repository/base_auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignOutUseCase extends BaseUseCase<void, NoParam> {
  final BaseAuthRepository _baseAuthRepository;

  SignOutUseCase(this._baseAuthRepository);

  @override
  Future<Either<Failure, void>> call(NoParam param) async {
    return await _baseAuthRepository.signOut();
  }
}
