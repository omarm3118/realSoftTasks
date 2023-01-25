import 'package:chat_app/features/authentication/presentation/components/default_text_form_field.dart';
import 'package:chat_app/features/chats/domain/entites/user_entity.dart';
import 'package:chat_app/features/chats/presentation/controllers/chatting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/app_constants.dart';
import '../../data/models/chat_model.dart';

class ChattingPage extends StatelessWidget {
  static const String route = 'chattingRoute';

  const ChattingPage({Key? key, required this.me, required this.to})
      : super(key: key);
  final UserEntity me;
  final UserEntity to;

  @override
  Widget build(BuildContext context) {
    ChattingBloc bloc = ChattingBloc.get(context)
      ..add(GetAllMessages(me.id, to.id));
    return Scaffold(
      backgroundColor: AppConstants.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          to.userName,
          style: TextStyle(
              color: AppConstants.userColors[to.colorIndex],
              fontSize: 30,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ChattingBloc, ChattingState>(
        listener: (context, state) {},
        buildWhen: (pState, cState) {
          if (cState is GetAllMessagesSuccessState ||
              cState is GetAllMessagesLoadingState ||
              cState is GetAllMessagesErrorState) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(AppConstants.kPadding),
            child: Column(
              children: [
                Expanded(child: successState(state)),
                const SizedBox(
                  height: 50,
                ),
                Form(
                  key: bloc.messageFormKey,
                  child: DefaultTextFormField(
                    textEditingController: bloc.messageController,
                    label: 'write a message ... ',
                    preIcon: null,
                    validator: messageValidator,
                    suffixIcon: IconButton(
                      icon: (state is SendAMessageLoadingState)
                          ? const CircularProgressIndicator()
                          : const Icon(Icons.send_outlined),
                      onPressed: () {
                        state is SendAMessageLoadingState
                            ? null
                            : bloc.add(SendAMessageEvent(me.id, to.id));
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget successState(state) {
    switch (state.runtimeType) {
      case GetAllMessagesLoadingState:
        return const Center(child: CircularProgressIndicator());
      case GetAllMessagesSuccessState:
        state as GetAllMessagesSuccessState;
        return ListView.separated(
            reverse: true,
            itemBuilder: (ctx, index) => messagesBuilder(state.chats[index]),
            separatorBuilder: (ctx, index) => const SizedBox(
                  height: 30,
                ),
            itemCount: state.chats.length);
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }

  Widget messagesBuilder(ChatModel chatModel) {
    bool isMe = me.id == chatModel.senderId;
    return Align(
      alignment: isMe?Alignment.topLeft:Alignment.topRight,
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.kPadding/2),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: !isMe ? Radius.circular(10) : Radius.zero,
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
                bottomEnd: isMe ? Radius.circular(10) : Radius.zero,
              ),
              color: isMe ? AppConstants.userColors[me.colorIndex].withOpacity(0.4) : AppConstants.userColors[to.colorIndex].withOpacity(0.4),
            ),
            child: Text(chatModel.message),
          )
        ],
      ),
    );
  }

  String? messageValidator(String? value) {
    if (value!.isEmpty) {
      return 'write some thing...';
    }
    return null;
  }
}
