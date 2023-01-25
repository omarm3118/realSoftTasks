import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/core/util/app_constants.dart';
import 'package:chat_app/features/authentication/presentation/controllers/login_controller_bloc.dart';
import 'package:chat_app/features/authentication/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/banner.dart';
import '../components/login_button.dart';
import '../components/login_info_section.dart';

class LoginPage extends StatelessWidget {
  static const String route = '/';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: AppConstants.statusBarColor,
      child: Scaffold(
          backgroundColor: AppConstants.scaffoldBackgroundColor,
          body: SafeArea(
            child: BlocListener<LoginControllerBloc, LoginControllerState>(
              listener: (context, state) {
                if (state is LoginErrorState) {
                  checkingDialog(
                    context,
                    state.message,
                  );
                } else if (state is LoginSuccessState) {
                  checkingDialog(
                    context,
                    'Login Successfully',
                    isSuccess: true,
                  );
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    MyBanner(),
                    // const AnimatedText(),
                    LoginInfoSection(),
                    LoginButton(),
                    GoToRegister(),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}



class GoToRegister extends StatelessWidget {
  const GoToRegister({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, SignUpPage.route);
            },
            child: const Text("Register Now")),
      ],
    );
  }
}

class AnimatedText extends StatelessWidget {
  const AnimatedText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: DefaultTextStyle(
        style:
            const TextStyle(fontSize: 30.0, color: AppConstants.defaultPurple),
        child: AnimatedTextKit(
          animatedTexts: [
            RotateAnimatedText('SECURE',
                duration: const Duration(seconds: AppConstants.kDuration)),
            RotateAnimatedText('ENCRYPTED',
                duration: const Duration(seconds: AppConstants.kDuration)),
            RotateAnimatedText('DIFFERENT',
                duration: const Duration(seconds: AppConstants.kDuration)),
          ],
          repeatForever: true,
        ),
      ),
    );
  }
}

String? emailValidator(String? text) {
  return text!.length < 6 ? 'email must be greater than 6' : null;
}

String? passwordValidator(String? text) {
  return text!.length < 6 ? 'password must be greater than 6 characters' : null;
}

String? userNameValidator(String? text) {
  return text!.isEmpty ? 'username must be empty' : null;
}
