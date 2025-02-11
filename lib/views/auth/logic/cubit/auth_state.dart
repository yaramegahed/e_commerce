part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class LoginSuccessState extends AuthState {}
class LoginLoadingState extends AuthState {}
class LoginErrorState extends AuthState {
  final String message;

  LoginErrorState({required this.message});
}
class RegisterErrorState extends AuthState {
  final String message;

  RegisterErrorState({required this.message});
}
class RegisterSuccessState extends AuthState {}
class RegisterLoadingState extends AuthState {

}

