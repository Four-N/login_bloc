part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
  //แจ้งเตือน bloc ว่า username ได้ถูก modified.
}

final class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
  //แจ้งเตือน bloc ว่า password ได้ถูก modified.
}

final class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
  //แจ้งเตือน bloc ว่า form ได้ถูก submit แล้ว.
}
