import 'package:e_commerce/views/auth/logic/cubit/auth_cubit.dart';
import 'package:e_commerce/views/auth/view/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/custom_button_profile.dart';
import 'edit_profile/edit_profile_screen.dart';
import 'my_orders/orders_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginLoadingState){
            Center(child: CircularProgressIndicator());
          }

          if (state is LogOutSuccessState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
          }
        },
        builder: (context, state) {
          AuthCubit cubit =BlocProvider.of(context);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(blurRadius: 7),
                          ],
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            CircleAvatar(
                              radius: 60,
                              child: Icon(Icons.person),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "User Name",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Email",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomButtonProfile(
                              text: 'Edit profile',
                              icon: Icons.person,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProfileScreen(),
                                    ));
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomButtonProfile(
                              text: 'My orders',
                              icon: CupertinoIcons.shopping_cart,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrdersScreen(),
                                    ));
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomButtonProfile(
                              text: 'Log out',
                              icon: Icons.logout,
                              onPressed: () {
                                cubit.logOut();
                              },
                            ),
                            SizedBox(
                              height: 120,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
