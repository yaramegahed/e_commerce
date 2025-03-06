part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

final class AuthInitial extends AuthState {}
final class LoginSuccessState extends AuthState {}
final class LoginLoadingState extends AuthState {}
final class LoginErrorState extends AuthState {
  final String message;

  LoginErrorState({required this.message});
}

final class RegisterErrorState extends AuthState {
  final String message;

  RegisterErrorState({required this.message});
}
final class RegisterSuccessState extends AuthState {}
final class RegisterLoadingState extends AuthState {}

final class GoogleSignInLoadingState extends AuthState {}
final class GoogleSignInSuccessState extends AuthState {}
final class GoogleSignInErrorState extends AuthState {}

final class LogOutLoadingState extends AuthState {}
final class LogOutSuccessState extends AuthState {}
final class LogOutErrorState extends AuthState {}

final class ResetPasswordErrorState extends AuthState {}
final class ResetPasswordLoadingState extends AuthState {}
final class ResetPasswordSuccessState extends AuthState {}

final class AddedDataSuccessState extends AuthState {}
final class AddedDataLoadingState extends AuthState {}
final class AddedDataErrorState extends AuthState {}

final class GetDataErrorState extends AuthState {}
final class GetDataSuccessState extends AuthState {}
final class GetDataLoadingState extends AuthState {}

