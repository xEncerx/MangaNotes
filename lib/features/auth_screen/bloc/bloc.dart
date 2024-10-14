import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:manga_notes/repositories/repositories.dart';
import 'package:talker/talker.dart';

part 'event.dart';
part 'state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final getIt = GetIt.I;
  final database = GetIt.I<DataBase>();

  AuthBloc() : super(AuthInitial()) {
    on<LoginAccountEvent>(
      (event, emit) async {
        if (state is! AuthFinished) {
          emit(AuthLogInLoading());
        }
        try {
          final result = await database.logIn(
            username: event.username,
            password: event.password,
          );
          result
              ? emit(AuthFinished(text: "Успешный вход в аккаунт!"))
              : emit(AuthLogInError());
        } catch (ex, st) {
          GetIt.I<Talker>().handle(ex, st);
          emit(AuthException(exception: ex));
        }
      },
    );
    on<CreateAccountEvent>(
      (event, emit) async {
        if (state is! AuthFinished) {
          emit(AuthSignUpLoading());
        }
        try {
          final recoveryCode = await database.signUp(
            username: event.username,
            password: event.password,
          );
          recoveryCode != null
              ? emit(AuthFinished(recoveryCode: recoveryCode))
              : emit(AuthSignUpError());
        } catch (ex, st) {
          getIt<Talker>().handle(ex, st);
          emit(AuthException(exception: ex));
        }
      },
    );
  }
}

class RecoveryPasswordBloc
    extends Bloc<RecoveryPasswordEvent, RecoveryPasswordState> {
  final database = GetIt.I<DataBase>();

  RecoveryPasswordBloc() : super(RecoveryPasswordInitial()) {
    on<CheckRecoveryCodeEvent>(
      (event, emit) async {
        if (state is! CheckRecoveryCodeStateLoaded) {
          emit(CheckRecoveryCodeStateLoading());
        }

        final result = await database.checkRecoveryCode(
          username: event.username,
          recoveryCode: event.code,
        );
        if (result) {
          emit(CheckRecoveryCodeStateLoaded());
        } else {
          emit(IncorrectRecoveryCode());
        }
      },
    );
    on<SaveNewPasswordEvent>((event, emit) async {
      if (state is! NewPasswordUpdated) {
        emit(NewPasswordLoading());
      }

      await database.updatePassword(
        username: event.username,
        password: event.newPassword,
      );
      emit(NewPasswordUpdated());
    });
  }
}
