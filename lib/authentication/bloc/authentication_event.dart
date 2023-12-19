part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

final class _AuthenticationStatusChanged extends AuthenticationEvent {
  const _AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  // แจ้งเตือนให้ bloc ของการเปลี่ยนแปลง Status ของผู้ใช้
}

final class AuthenticationLogoutRequested extends AuthenticationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  // แจ้งเตือนให้ bloc ของการขอ logout
}
