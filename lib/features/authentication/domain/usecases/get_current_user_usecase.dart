import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/usecase/base_usecase.dart';
import 'package:chat_app/features/authentication/data/models/user_auth_model.dart';
import 'package:dartz/dartz.dart';

import '../repository/base_auth_repository.dart';

class GetCurrentUserUseCase extends BaseUseCase<UserAuthModel,NoParam>{
  final BaseAuthRepository _baseAuthRepository;

  GetCurrentUserUseCase(this._baseAuthRepository);

  @override
  Future<Either<Failure, UserAuthModel>> call(NoParam param)async {
    return _baseAuthRepository.getCurrentUser();
  }

}