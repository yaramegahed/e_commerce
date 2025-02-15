import 'package:bloc/bloc.dart';
import 'package:e_commerce/views/auth/logic/model/user_data.dart';
import 'package:flutter/foundation.dart';
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
      await getData();
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
      await addData(email: email, name: name);
      await getData();
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
    const webClientId =
        '110137516942-l4ggavjvld3feld69euc7i151dk40tsr.apps.googleusercontent.com';
    const iosClientId = 'my-ios.apps.googleusercontent.com';
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
    await addData(
        email: googleUser.email, name: googleUser.displayName ?? "null name");
    await getData();
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

  Future<void> addData({required String email, required String name}) async {
    emit(AddedDataLoadingState());
    try {
      await client.from("users").upsert({
        "user_id": client.auth.currentUser!.id,
        "name": name,
        "email": email,
      });
      emit(AddedDataSuccessState());
    } catch (e) {
      print(e);
      emit(AddedDataErrorState());
    }
  }

  UserDataModel? userDataModel;

  Future<void> getData() async {
    emit(GetDataLoadingState());
    try {
      final data = await client
          .from("users")
          .select()
          .eq("user_id", client.auth.currentUser!.id);
      userDataModel = UserDataModel(
          userId: data[0]["user_id"],
          name: data[0]["name"],
          email: data[0]["email"]);
      emit(GetDataSuccessState());
    } catch (e) {
      print(e);
      emit(GetDataErrorState());
    }
  }
}
