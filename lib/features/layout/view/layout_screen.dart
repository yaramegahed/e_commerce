import 'package:e_commerce/features/auth/logic/model/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../fav/view/favorite_screen.dart';
import '../../home/view/home_screen.dart';
import '../../profile/view/profile_screen.dart';
import '../../shop/view/shop_screen.dart';
import '../logic/layout_cubit.dart';
import '../logic/layout_state.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key, required this.model, });
   final UserDataModel model;
  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(model: widget.model,
      ),
      ShopScreen(),
      FavoriteScreen(),
      ProfileScreen()
    ];
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          LayoutCubit cubit = BlocProvider.of(context);
          return Scaffold(
            body: screens[cubit.currentIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: GNav(
                rippleColor: Colors.blueAccent,
                gap: 8,
                activeColor: Colors.white,
                iconSize: 30,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                duration: Duration(milliseconds: 200),
                tabBackgroundColor: Colors.blueAccent,
                color: Colors.grey,
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.storefront,
                    text: 'Store',
                  ),
                  GButton(
                    icon: Icons.favorite,
                    text: 'Favorite',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  ),
                ],
                onTabChange: (index) {
                  setState(() {
                    cubit.changeIndex(index);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
