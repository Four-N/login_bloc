part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  const AuthenticationState.unknown()
      : this._(); //เป็น Default state เพื่อบอกว่า bloc ยังไม่รู้ว่าผู้ใช้ปัจจุบันได้รับการ authen หรือไม่

  const AuthenticationState.authenticated(
      User user) //เป็น state ที่บอกว่า ผู้ใช้ปัจจุบันได้รับการ authen แล้ว
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated() //เป็น state ที่บอกว่า ผู้ใช้ปัจจุบันยังไม่ได้ได้รับการ authen
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
