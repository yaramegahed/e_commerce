import 'package:e_commerce/core/home_cubit/home_cubit.dart';
import 'package:e_commerce/core/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/widget/custom_product_list.dart';
import '../product_details/view/product_details_screen.dart';

class FavoriteScreen extends StatelessWidget {
  final HomeModel? model;

  const FavoriteScreen({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getFav(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Favorites",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        HomeCubit cubit = BlocProvider.of(context);
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                      model: model,
                                    ),
                                  ));
                            },
                            child: CustomProductList(
                              model: cubit.favList[index],
                              wrap: false,
                              physics: AlwaysScrollableScrollPhysics(),
                              isFav: true,
                            ));

                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: context.read<HomeCubit>().favList.length,
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
