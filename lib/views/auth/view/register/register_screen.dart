import 'package:e_commerce/views/auth/logic/cubit/auth_cubit.dart';
import 'package:e_commerce/views/auth/view/login/login_screen.dart';
import 'package:e_commerce/views/layout/view/layout_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordInvisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterLoadingState) {
          Center(child: CircularProgressIndicator());
        }
          if (state is RegisterSuccessState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
          }

          if (state is RegisterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red, content: Text(state.message)));
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          AuthCubit cubit = BlocProvider.of(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(CupertinoIcons.back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: state is RegisterLoadingState
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 2),
                            ),
                            CustomTextField(
                              prefixIcon: Icons.person,
                              label: 'name',
                              hint: '',
                              suffixIcon: Icons.cancel,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              prefixIcon: Icons.email,
                              label: 'email',
                              hint: '',
                              suffixIcon: Icons.cancel,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              obscureText: isPasswordInvisible,
                              prefixIcon: Icons.password,
                              label: 'password',
                              hint: '',
                              onTap: (){setState(() {
                                isPasswordInvisible=! isPasswordInvisible;
                              });},
                              suffixIcon: isPasswordInvisible
                                  ? CupertinoIcons.eye_slash
                                  : Icons.visibility,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              obscureText: true,
                              prefixIcon: Icons.password,
                              label: 'repeat password',
                              hint: '',
                              suffixIcon: CupertinoIcons.eye,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              prefixIcon: Icons.date_range,
                              label: 'Birth day',
                              hint: '',
                              suffixIcon: Icons.cancel,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              prefixIcon: Icons.phone,
                              label: 'phone',
                              hint: '',
                              suffixIcon: Icons.cancel_sharp,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: TextButton(
                                style: const ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.indigo),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.register(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text);
                                  }
                                },
                                child: const Text(
                                  "sign up",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
