import 'dart:async';

import 'package:chat_app/core/error/error_message_model.dart';
import 'package:chat_app/core/error/exceptions.dart';
import 'package:chat_app/features/chats/data/models/chat_model.dart';
import 'package:chat_app/features/chats/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseDBRemote {
  Future<void> insertUserData(
      {required String userName,
      required int avatarColor,
      required String userId,
      required String email});

  Future<List<UserModel>> getAllUsers();

  Future<UserModel> getUserInfo();

  Future<void> sendMessage(
      {required String senderId,
      required String receiverId,
      required ChatModel data});

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      {required String senderId, required String receiverId});
}

class DBRemote extends BaseDBRemote {
  final FirebaseFirestore _firebaseFireStore;

  DBRemote(this._firebaseFireStore);

  @override
  Future<void> insertUserData(
      {required String userName,
      required int avatarColor,
      required String userId,
      required String email}) async {
    try {
      return await _firebaseFireStore.collection('users').doc(userId).set({
        'userName': userName,
        'avatarColor': avatarColor,
        'userId': userId,
        'email': email
      });
    } catch (error) {
      throw ServerException(ErrorMessageModel(message: error.toString()));
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> future =
          await _firebaseFireStore.collection('users').get();
      return future.docs
          .map((e) => UserModel.fromJson(data: e.data()))
          .toList();
    } catch (error) {
      throw ServerException(ErrorMessageModel(message: error.toString()));
    }
  }

  @override
  Future<UserModel> getUserInfo() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firebaseFireStore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      return UserModel.fromJson(data: snapshot.data()!);
    } catch (error) {
      throw ServerException(ErrorMessageModel(message: error.toString()));
    }
  }

  @override
  Future<void> sendMessage(
      {required String senderId,
      required String receiverId,
      required ChatModel data}) async {
    try {
      WriteBatch batch = _firebaseFireStore.batch();

      var doc1 = _firebaseFireStore
          .collection('chats')
          .doc(senderId)
          .collection('messages')
          .doc(receiverId)
          .collection('messages')
          .doc();
      var doc2 = _firebaseFireStore
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .doc(senderId)
          .collection('messages')
          .doc();
      batch.set(doc1, {...data.toJson(), 'messageId': doc1.id});
      batch.set(doc2, {...data.toJson(), 'messageId': doc2.id});
      return await batch.commit();
    } catch (error) {
      throw ServerException(ErrorMessageModel(message: error.toString()));
    }
  }

  @override
    Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      {required String senderId, required String receiverId}) {
    try {
      return
       _firebaseFireStore
          .collection('chats')
          .doc(senderId)
          .collection('messages')
          .doc(receiverId)
          .collection('messages')
          .orderBy('messageDate', descending: true)
          .snapshots();


    } catch (error) {
      throw ServerException(ErrorMessageModel(message: error.toString()));
    }
  }
}
