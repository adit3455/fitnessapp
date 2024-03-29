import 'package:fitness_app/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(UnAuthenticated()) {
    on<SignInRequested>((event, emit) async {
      try {
        await _authRepository.signIn(
            email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<SignUpRequested>((event, emit) async {
      try {
        await _authRepository.signUp(
            email: event.email,
            password: event.password,
            firstName: event.firstName,
            lastName: event.lastName);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<GoogleSignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await _authRepository.signInWithGoogle();
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<DeleteUser>((event, emit) async {
      emit(Loading());
      try {
        await _authRepository.deleteUser();
        emit(UnAuthenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
    on<UpdateDisplayName>((event, emit) async {
      try {
        if (_authRepository.authDisplayName == event.name) {
          emit(const AuthError(
              "Your name is Same as Before. you must change your name!"));
        } else if (_authRepository.authDisplayName != event.name) {
          _authRepository.updateDisplayName(name: event.name);
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      try {
        await _authRepository.signOut();
        emit(UnAuthenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}
