import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/usecase/base_usecase.dart';
import 'package:chat_app/features/authentication/data/models/user_auth_model.dart';
import 'package:chat_app/features/authentication/domain/repository/base_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginUseCase extends BaseUseCase<UserAuthModel, UserAuthParam> {
  final BaseAuthRepository _baseAuthRepository;

  LoginUseCase(this._baseAuthRepository);

  @override
  Future<Either<Failure, UserAuthModel>> call(UserAuthParam param)async {
return await _baseAuthRepository.loginWithEmailAndPassword(param);
  }
}

class UserAuthParam extends Equatable {
  final String email;
  final String password;

  const UserAuthParam(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
