part of 'bloc.dart';

sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLogInLoading extends AuthState {}

final class AuthSignUpLoading extends AuthState {}

final class AuthFinished extends AuthState {
  final String? text;
  final String? recoveryCode;

  AuthFinished({this.text, this.recoveryCode});
  @override
  List<Object?> get props => super.props..addAll([text, recoveryCode]);
}

final class AuthLogInError extends AuthState {}

final class AuthSignUpError extends AuthState {}

final class AuthException extends AuthState {
  final Object? exception;

  AuthException({this.exception});

  @override
  List<Object?> get props => super.props..add(exception);
}

sealed class RecoveryPasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class RecoveryPasswordInitial extends RecoveryPasswordState {}

final class CheckRecoveryCodeStateLoading extends RecoveryPasswordState {}

final class CheckRecoveryCodeStateLoaded extends RecoveryPasswordState {}

final class IncorrectRecoveryCode extends RecoveryPasswordState {}

final class NewPasswordLoading extends RecoveryPasswordState {}

final class NewPasswordUpdated extends RecoveryPasswordState {}
