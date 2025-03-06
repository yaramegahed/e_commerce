import 'package:e_commerce/features/auth/view/login/widget/expanded_row.dart';
import 'package:e_commerce/features/auth/view/login/widget/forget_password.dart';
import 'package:e_commerce/features/auth/view/login/widget/google_container.dart';
import 'package:e_commerce/features/auth/view/login/widget/signup_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/custom_text_field.dart';
import '../../../layout/view/layout_screen.dart';
import '../../logic/cubit/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isPasswordInvisible = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            Center(child: CircularProgressIndicator());
          }
          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red, content: Text(state.message)));
          }
          if (state is LoginSuccessState || state is GoogleSignInSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text("User logged in successfully"),
            ));

            final userModel = context.read<AuthCubit>().userDataModel;

            if (userModel != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LayoutScreen(model: userModel),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          AuthCubit cubit = BlocProvider.of(context);
          return Scaffold(
              body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome to our market",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextField(
                    controller: emailController,
                    prefixIcon: Icons.email,
                    label: "email",
                    hint: "",
                    suffixIcon: Icons.cancel_sharp,
                    onTap: emailController.clear,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    obscureText: isPasswordInvisible,
                    prefixIcon: Icons.password,
                    onTap: () {
                      setState(() {
                        isPasswordInvisible = !isPasswordInvisible;
                      });
                    },
                    label: "password",
                    hint: "",
                    suffixIcon: isPasswordInvisible
                        ? CupertinoIcons.eye_slash
                        : Icons.visibility,
                  ),
                  ForgetPasswordText(),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.indigo),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.login(
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ExpandedRow(),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: cubit.googleSignIn,
                    child: GoogleContainer(),
                  ),
                  SignupRow()
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
