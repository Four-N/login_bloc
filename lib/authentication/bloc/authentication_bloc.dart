import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown())
  //ใช้ dependencies ของ  Auth Repo และ User Repo มากำหนดค่าเริ่มต้นใหม่เป็น AuthenticationState.unknown()
  {
    on<_AuthenticationStatusChanged>(
        _onAuthenticationStatusChanged); //จะถูกเรียกเมื่อมีการเปลี่ยนแปลงสถานะ
    on<AuthenticationLogoutRequested>(
        _onAuthenticationLogoutRequested); //จะถูกเรียกเมื่อมีคำขอออกจากระบบ
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(_AuthenticationStatusChanged(
          status)), //จัดการการติดตามการเปลี่ยนแปลงสถานะและเพิ่ม event ที่เกี่ยวข้อง
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close(); //ไว้ยกเลิกการตรวจสอบ authen
  }

  //เมื่อ AuthStatusChanged มีการเพิ่ม event สถานะที่เกียวข้องคือ AuthStatus.authenticated ,Auth Bloc จะ queries user ผ่าน UserRepo
  Future<void> _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return emit(
          user != null
              ? AuthenticationState.authenticated(user)
              : const AuthenticationState.unauthenticated(),
        );
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}
