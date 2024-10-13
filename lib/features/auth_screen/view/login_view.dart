import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_notes/features/features.dart';
import 'package:manga_notes/generated/assets.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
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
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.imagesWelcome,
                  height: 300,
                ),
                Text(
                  "MangaNotes",
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Привет! Чтобы пользовать приложением нужно авторизоваться в аккаунт.",
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
                  suffix: IconButton(
                    onPressed: () => _openRecoverPasswordDialog(),
                    icon: Icon(
                      Icons.help_outline,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _LogInButton(
                  usernameController: _usernameController,
                  passwordController: _passwordController,
                  formKey: _formKey,
                ),
                const SizedBox(height: 5),
                AuthTextActionButton(
                  onTap: () => _openCreateAccountView(context),
                  text: "Создать аккаунт",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openRecoverPasswordDialog() => showRecoverDialog(context);

  void _openCreateAccountView(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignUpView(),
      ),
    );
  }
}

class _LogInButton extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const _LogInButton({
    required this.usernameController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLogInLoading) {
          return SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          );
        }

        return AuthFilledActionButton(
          text: "Войти в аккаунт",
          onTap: () => _logIn(context),
        );
      },
    );
  }

  void _logIn(BuildContext context) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        LoginAccountEvent(
          username: usernameController.text,
          password: passwordController.text,
        ),
      );
    }
  }
}
