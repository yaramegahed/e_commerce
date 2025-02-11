import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  SupabaseClient client = Supabase.instance.client;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      await client.auth.signInWithPassword(password: password, email: email);
      emit(LoginSuccessState());
    } on AuthException catch (e) {
      print(e.toString());
      emit(LoginErrorState(message: e.message));
    } catch (e) {
      print(e);
    }
  }

  Future<void> register(
      {required String email,
      required String password,
      required String name}) async {
    emit(RegisterLoadingState());
    try {
      await client.auth.signUp(password: password, email: email);
      emit(RegisterSuccessState());
    } on AuthException catch (e) {
      print(e.toString());
      emit(RegisterErrorState(message: e.message));
    } catch (e) {
      print(e);
    }
  }
}
