part of 'bloc.dart';

sealed class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class LoginAccountEvent extends AuthEvent {
  final String username;
  final String password;

  LoginAccountEvent({required this.username, required this.password});

  @override
  List<Object?> get props => super.props..addAll([username, password]);
}

final class CreateAccountEvent extends AuthEvent {
  final String username;
  final String password;

  CreateAccountEvent({required this.username, required this.password});

  @override
  List<Object?> get props => super.props..addAll([username, password]);
}

sealed class RecoveryPasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CheckRecoveryCodeEvent extends RecoveryPasswordEvent {
  final String username;
  final String code;

  CheckRecoveryCodeEvent({required this.username, required this.code});

  @override
  List<Object?> get props => super.props..addAll([username, code]);
}

final class SaveNewPasswordEvent extends RecoveryPasswordEvent {
  final String username;
  final String newPassword;

  SaveNewPasswordEvent({required this.username, required this.newPassword});

  @override
  List<Object?> get props => super.props..addAll([username, newPassword]);
}
