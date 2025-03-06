import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/custom_text_field.dart';
import '../../logic/cubit/auth_cubit.dart';
import '../login/login_screen.dart';

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
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(backgroundColor: Colors.green, content: Text("successful sign up")));
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
                icon: Icon(CupertinoIcons.back, size: 30,),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("Sign Up", style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 15,),
                      CustomTextField(
                        controller: nameController,
                        prefixIcon: Icons.person,
                        label: 'name',
                        hint: '',
                        suffixIcon: Icons.cancel,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: emailController,
                        prefixIcon: Icons.email,
                        label: 'email',
                        hint: '',
                        suffixIcon: Icons.cancel,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        obscureText: isPasswordInvisible,
                        prefixIcon: Icons.password,
                        label: 'password',
                        hint: '',
                        onTap: () {
                          setState(() {
                            isPasswordInvisible = !isPasswordInvisible;
                          });
                        },
                        suffixIcon: isPasswordInvisible
                            ? CupertinoIcons.eye_slash
                            : Icons.visibility,
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
