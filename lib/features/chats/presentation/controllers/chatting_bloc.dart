import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/chats/data/models/chat_model.dart';
import 'package:chat_app/features/chats/domain/usecases/get_messages_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/send_message_usecase.dart';

part 'chatting_event.dart';

part 'chatting_state.dart';

class ChattingBloc extends Bloc<ChattingEvent, ChattingState> {
  final SendMessageUseCase _sendMessageUseCase;
  final GetMessagesUseCase _getMessagesUseCase;

  ChattingBloc(this._sendMessageUseCase, this._getMessagesUseCase)
      : super(ChattingInitial()) {
    on<SendAMessageEvent>(_sendAMessage);
    on<GetAllMessages>(_getAllMessage);
  }

  static ChattingBloc get(context) => BlocProvider.of<ChattingBloc>(context);

  final TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> messageFormKey = GlobalKey<FormState>();

  _sendAMessage(SendAMessageEvent event, Emitter<ChattingState> emit) async {
    if (checkValidation()) {
      emit(SendAMessageLoadingState());
      Either<Failure, void> result = await _sendMessageUseCase(
        MessageParam(
          event.senderId,
          event.receiverId,
          ChatModel(
            senderId: event.senderId,
            receiverId: event.receiverId,
            messageDate: DateTime.now().toString(),
            message: messageController.text,
          ),
        ),
      );
      result.fold((l) => emit(SendAMessageErrorState(l.message)), (r) {
        messageController.clear();
        emit(SendAMessageSuccessState());
      });
    }
  }

  checkValidation() {
    return messageFormKey.currentState!.validate();
  }

  _getAllMessage(GetAllMessages event, Emitter<ChattingState> emitt) async {
     emit(GetAllMessagesLoadingState());

    Either<Failure, Stream<QuerySnapshot<Object?>>> result =
        await _getMessagesUseCase(
      GetMessagesParam(event.senderId, event.receiverId),
    );
    result.fold(
        (l) => emit(GetAllMessagesErrorState(l.message)),
        (r) => r.listen((event) {
              List<ChatModel> chats = event.docs
                  .map(
                    (e) => ChatModel.fromJson(
                        data: e.data() as Map<String, dynamic>),
                  )
                  .toList();
              print('hello');
              emit(GetAllMessagesSuccessState(chats));
            }));
  }
}
