import 'package:chat_app/core/util/app_constants.dart';
import 'package:chat_app/core/util/conditional_builder.dart';
import 'package:chat_app/features/authentication/presentation/controllers/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/default_button.dart';
import '../components/banner.dart';
import '../components/default_text_form_field.dart';
import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  static const String route = 'signUpRoute';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: AppConstants.statusBarColor,
        child: Scaffold(
          backgroundColor: AppConstants.scaffoldBackgroundColor,
          body: SafeArea(
            child: BlocListener<SignUpBloc, SignUpState>(
              listener: (context, state) {
                if (state is SignUpErrorState) {
                  checkingDialog(
                    context,
                    state.message,
                  );
                } else if (state is SignUpSuccessState) {
                  checkingDialog(
                    context,
                    'Register Successfully',
                    isSuccess: true,
                  );
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    MyBanner(),
                    RegisterInfoSection(),
                    RegisterButton(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpBloc sBloc = SignUpBloc.get(context);

    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.all(AppConstants.kPadding),
            child: ConditionalBuilder(
              successWidget: (_) {
                return DefaultButton(
                  label: 'REGISTER',
                  onPressed: () {
                    sBloc.add(SignUpWithEmailAndPasswordEvent(
                        email: sBloc.emailController.text,
                        password: sBloc.passwordController.text));
                  },
                  labelStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                );
              },
              fallbackWidget: (_) =>
              const Center(
                child: CircularProgressIndicator(),
              ),
              condition: state is! SignUpLoadingState,
            ));
      },
    );
  }
}

class RegisterInfoSection extends StatelessWidget {
  const RegisterInfoSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpBloc sBloc = SignUpBloc.get(context);
    return SizedBox(
      height: 600,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.kPadding),
        child: Card(
          elevation: 8,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.kPadding),
            child: Form(
              key: sBloc.getFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Register NOW',
                      style: TextStyle(color: AppConstants.defaultPurple)),
                  const SizedBox(
                    height: 50,
                  ),
                  DefaultTextFormField(
                    textEditingController: sBloc.userNameController,
                    label: 'username',
                    preIcon: const Icon(Icons.person_outline_outlined),
                    keyboardType: TextInputType.name,
                    validator: userNameValidator,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  DefaultTextFormField(
                    textEditingController: sBloc.emailController,
                    label: 'email',
                    preIcon: const Icon(Icons.email_outlined),
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  DefaultTextFormField(
                    textEditingController: sBloc.passwordController,
                    label: 'password',
                    preIcon: const Icon(Icons.email_outlined),
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: passwordValidator,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Choose Your Avatar Color',
                    style: TextStyle(
                        fontSize: 20, color: AppConstants.defaultPurple),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const UserAvatarColors()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

GestureDetector avatarColor({
  required Color color,
  required index,
  required SignUpBloc bloc,
}) {
  return GestureDetector(
    onTap: () {
      bloc.changeAvatarColor(index);
    },
    child: Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: index == bloc.currentIndex
            ? Border.all(color: Colors.purple)
            : null,
      ),
      child: Card(
        shape: const CircleBorder(),
        color: color,
        elevation: 10,
        shadowColor: color,
      ),
    ),
  );
}

class UserAvatarColors extends StatelessWidget {
  const UserAvatarColors({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List<Widget>.generate(
              AppConstants.userColors.length,
                  (index) =>
                  avatarColor(
                      color: AppConstants.userColors[index],
                      index: index,
                      bloc: SignUpBloc.get(context)),
            ).toList());
      },
    );
  }
}
