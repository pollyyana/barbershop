import 'package:flutter/foundation.dart';

enum LoginStateStatus {
  initial,
  error,
  admLogin,
  employeeLogin,
}

class LoginState {
  LoginState.initial() : this(status: LoginStateStatus.initial);

  LoginState({
    required this.status,
    this.errorMessage,
  });
  final LoginStateStatus status;
  final String? errorMessage;

  LoginState copyWith({
    LoginStateStatus? status,
   ValueGetter <String?>? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage, 
    );
  }
}
