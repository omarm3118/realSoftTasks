import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/usecase/base_usecase.dart';
import 'package:chat_app/features/authentication/data/models/user_auth_model.dart';
import 'package:chat_app/features/authentication/domain/repository/base_auth_repository.dart';
import 'package:dartz/dartz.dart';

import 'login_usecase.dart';

class SignUpUseCase extends BaseUseCase<UserAuthModel, UserAuthParam> {
  final BaseAuthRepository _baseAuthRepository;

  SignUpUseCase(this._baseAuthRepository);

  @override
  Future<Either<Failure, UserAuthModel>> call(UserAuthParam param) async {
    return await _baseAuthRepository.signUpWithEmailAndPassword(param);
  }
}
