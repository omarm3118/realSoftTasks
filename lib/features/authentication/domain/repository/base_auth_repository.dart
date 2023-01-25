import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/authentication/data/models/user_auth_model.dart';
import 'package:chat_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, UserAuthModel>> loginWithEmailAndPassword(
      UserAuthParam userAuthParam);

  Future<Either<Failure, UserAuthModel>> signUpWithEmailAndPassword(
      UserAuthParam userAuthParam);

  Future<Either<Failure, void>> signOut();

  Either<Failure, UserAuthModel> getCurrentUser();
}
