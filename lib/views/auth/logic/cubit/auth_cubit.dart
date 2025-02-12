import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  GoogleSignIn? googleUser;

  Future<AuthResponse> googleSignIn() async {
    emit(GoogleSignInLoadingState());

    /// TODO: update the Web client ID with your own.
    ///
    /// Web Client ID that you registered with Google Cloud.
    const webClientId =
        '110137516942-l4ggavjvld3feld69euc7i151dk40tsr.apps.googleusercontent.com';

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId = 'my-ios.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return AuthResponse();
    }
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null) {
      emit(GoogleSignInErrorState());
      return AuthResponse();
    }

    AuthResponse response = await client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
    emit(GoogleSignInSuccessState());
    return response;
  }

  Future<void> logOut() async {
    emit(LogOutLoadingState());
    try {
      client.auth.signOut();
      emit(LogOutSuccessState());
    } catch (e) {
      emit(LogOutErrorState());
    }
  }

  Future<void> resetPassword({required String email}) async {
    emit(ResetPasswordLoadingState());
    try {
      client.auth.resetPasswordForEmail(email);
      emit(ResetPasswordSuccessState());
    } catch (e) {
      emit(ResetPasswordErrorState());
    }
  }
}
