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
class RegisterLoadingState extends AuthState {}

class GoogleSignInLoadingState extends AuthState {}
class GoogleSignInSuccessState extends AuthState {}
class GoogleSignInErrorState extends AuthState {}

class LogOutLoadingState extends AuthState {}
class LogOutSuccessState extends AuthState {}
class LogOutErrorState extends AuthState {}

class ResetPasswordErrorState extends AuthState {}
class ResetPasswordLoadingState extends AuthState {}
class ResetPasswordSuccessState extends AuthState {}

