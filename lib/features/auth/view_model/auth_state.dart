abstract class AuthCubitState {}

class AuthInitial extends AuthCubitState {}

class AuthLoading extends AuthCubitState {}

class AuthSuccess extends AuthCubitState {
  final bool needsConfirmation;
  AuthSuccess({this.needsConfirmation = false});
}

class AuthError extends AuthCubitState {
  final String message;
  AuthError(this.message);
}