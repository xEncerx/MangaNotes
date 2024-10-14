import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_notes/generated/assets.dart';

import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.imagesSignUp,
                  height: 300,
                ),
                Text(
                  "MangaNotes",
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Придумай username и пароль.",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleSmall?.copyWith(
                    overflow: TextOverflow.visible,
                  ),
                ),
                AuthTextField(
                  controller: _usernameController,
                  labelText: "Username",
                ),
                AuthTextField(
                  controller: _passwordController,
                  labelText: "Password",
                  obscureText: true,
                  usePasswordValidator: true,
                ),
                const SizedBox(height: 20),
                _SignUpButton(
                  usernameController: _usernameController,
                  passwordController: _passwordController,
                  formKey: _formKey,
                ),
                const SizedBox(height: 5),
                AuthTextActionButton(
                  onTap: () => _openLoginAccountView(context),
                  text: "У меня есть аккаунт",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openLoginAccountView(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class _SignUpButton extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const _SignUpButton({
    required this.usernameController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSignUpLoading) {
          return const SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          );
        }

        return AuthFilledActionButton(
          text: "Создать аккаунт",
          onTap: () => _signUp(context),
        );
      },
    );
  }

  void _signUp(BuildContext context) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        CreateAccountEvent(
          username: usernameController.text,
          password: passwordController.text,
        ),
      );
    }
  }
}
