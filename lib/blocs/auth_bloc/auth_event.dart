part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// When the user signing in with email and password this event is called and the [AuthRepository] is called to sign in the user
class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

// When the user signing up with email and password this event is called and the [AuthRepository] is called to sign up the user
class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  const SignUpRequested(
      this.email, this.password, this.firstName, this.lastName);

  @override
  List<Object> get props => [email, password, firstName, lastName];
}

// When the user signing in with google this event is called and the [AuthRepository] is called to sign in the user
class GoogleSignInRequested extends AuthEvent {
  @override
  List<Object> get props => [];
}

// When the user signing out this event is called and the [AuthRepository] is called to sign out the user
class SignOutRequested extends AuthEvent {}

class DeleteUser extends AuthEvent {}

class UpdateDisplayName extends AuthEvent {
  final String name;

  const UpdateDisplayName(this.name);

  @override
  List<Object> get props => [name];
}
