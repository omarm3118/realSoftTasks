import 'package:chat_app/core/error/error_message_model.dart';
import 'package:chat_app/core/error/exceptions.dart';
import 'package:chat_app/features/authentication/data/models/user_auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuthRemote {
  Future<UserAuthModel> signUpWithEmailAndPassword(
      {required String email, required String password});

  Future<UserAuthModel> loginWithEmailAndPassword(
      {required String email, required String password});

  Future<void> signOut();
  UserAuthModel getCurrentUser();
}

class AuthRemote extends BaseAuthRemote {
  final FirebaseAuth firebaseAuth;

  AuthRemote({required this.firebaseAuth});

  @override
  Future<UserAuthModel> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        return UserAuthModel(
            userCredential.user!.email!, userCredential.user!.uid);
      } else {
        throw ServerException( ErrorMessageModel(message: ''));
      }
    } catch (error) {
      throw ServerException(ErrorMessageModel(message: error.toString()));
    }
  }

  @override
  Future<UserAuthModel> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        return UserAuthModel(
            userCredential.user!.email!, userCredential.user!.uid);
      } else {
        throw ServerException( ErrorMessageModel(message: ''));
      }
    } catch (error) {
      throw ServerException(ErrorMessageModel(message: error.toString()));
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (error) {
      throw ServerException(ErrorMessageModel(message: error.toString()));
    }
  }

  @override
  UserAuthModel getCurrentUser()  {
    try {
      User? user =   firebaseAuth.currentUser;
      if (user != null) {
        return UserAuthModel(
            user.email!, user.uid);
      } else {
        throw ServerException( ErrorMessageModel());
      }
    } catch (error) {
      throw ServerException(ErrorMessageModel());
    }
  }
}
