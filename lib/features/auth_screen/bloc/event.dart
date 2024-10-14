part of 'bloc.dart';

sealed class AuthEvent {}

sealed class RecoveryPasswordEvent {}

final class LoginAccountEvent extends AuthEvent {
  final String username;
  final String password;

  LoginAccountEvent({required this.username, required this.password});
}

final class CreateAccountEvent extends AuthEvent {
  final String username;
  final String password;

  CreateAccountEvent({required this.username, required this.password});
}

final class CheckRecoveryCodeEvent extends RecoveryPasswordEvent {
  final String username;
  final String code;

  CheckRecoveryCodeEvent({required this.username, required this.code});
}

final class SaveNewPasswordEvent extends RecoveryPasswordEvent {
  final String username;
  final String newPassword;

  SaveNewPasswordEvent({required this.username, required this.newPassword});
}
