import 'package:chat_app/core/error/exceptions.dart';
import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/authentication/data/datasource/firebase_auth_remote.dart';
import 'package:chat_app/features/authentication/data/models/user_auth_model.dart';
import 'package:chat_app/features/authentication/domain/repository/base_auth_repository.dart';
import 'package:chat_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImp extends BaseAuthRepository {
  final AuthRemote _authRemote;

  AuthRepoImp(this._authRemote);

  @override
  Future<Either<Failure, UserAuthModel>> loginWithEmailAndPassword(
      UserAuthParam userAuthParam) async {
    try {
      UserAuthModel userAuthModel = await _authRemote.loginWithEmailAndPassword(
          email: userAuthParam.email, password: userAuthParam.password);
      return Right(userAuthModel);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, UserAuthModel>> signUpWithEmailAndPassword(
      UserAuthParam userAuthParam) async {
    try {
      UserAuthModel userAuthModel =
          await _authRemote.signUpWithEmailAndPassword(
              email: userAuthParam.email, password: userAuthParam.password);
      return Right(userAuthModel);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authRemote.signOut();
      return const Right(null);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Either<Failure, UserAuthModel> getCurrentUser() {

    try {
       UserAuthModel currentUser = _authRemote.getCurrentUser();
      return  Right(currentUser);
    } on ServerException catch(error){
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }
}
