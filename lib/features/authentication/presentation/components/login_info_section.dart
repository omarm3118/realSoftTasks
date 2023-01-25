import 'package:chat_app/features/authentication/presentation/controllers/login_controller_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../core/util/app_constants.dart';
import '../pages/login_page.dart';
import 'default_text_form_field.dart';

class LoginInfoSection extends StatelessWidget {
  const LoginInfoSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginControllerBloc bloc = LoginControllerBloc.get(context);
    return SizedBox(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.kPadding),
        child: Card(
          elevation: 8,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.kPadding),
            child: Form(
              key: bloc.getFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('LOGIN NOW',
                      style: TextStyle(color: AppConstants.defaultPurple)),
                  const SizedBox(
                    height: 50,
                  ),
                  DefaultTextFormField(
                      textEditingController: bloc.emailController,
                      label: 'email',
                      preIcon: const Icon(Icons.email_outlined),
                      keyboardType: TextInputType.emailAddress,
                      validator: emailValidator),
                  const SizedBox(
                    height: 30,
                  ),
                  DefaultTextFormField(
                    textEditingController: bloc.passwordController,
                    label: 'password',
                    preIcon: const Icon(Icons.email_outlined),
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: passwordValidator,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
