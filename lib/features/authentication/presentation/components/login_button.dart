import 'package:chat_app/core/util/conditional_builder.dart';
import 'package:chat_app/features/authentication/presentation/controllers/login_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/app_constants.dart';
import '../../../../core/util/default_button.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginControllerBloc bloc = LoginControllerBloc.get(context);
    return BlocBuilder<LoginControllerBloc, LoginControllerState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(AppConstants.kPadding),
          child: ConditionalBuilder(
            successWidget: (ctx) {
              return DefaultButton(
                label: 'LOGIN',
                onPressed: () {
                  bloc.add(LoginWithEmailAndPasswordEvent(
                      email: bloc.emailController.text,
                      password: bloc.passwordController.text));
                },
                labelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              );
            },
            fallbackWidget: (ctx) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            condition: state is! LoginLoadingState,
          ),
        );
      },
    );
  }
}
