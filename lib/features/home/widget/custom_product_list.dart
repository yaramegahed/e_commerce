import 'package:e_commerce/core/home_cubit/home_cubit.dart';
import 'package:e_commerce/core/models/home_model.dart';
import 'package:e_commerce/features/home/widget/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomProductList extends StatelessWidget {
  final bool? wrap;
  final ScrollPhysics? physics;
  final HomeModel? model;
  final String? query;
  final String? category;
  final void Function()? onPressed;
  final bool isFav;
  final bool isOrder;

  const CustomProductList({
    super.key,
    this.wrap,
    this.physics,
    this.model,
    this.query,
    this.category,
    this.onPressed,
    this.isFav = false,
    this.isOrder = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit()..getProducts(query: query, category: category),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is BuySuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text("Payment success ,check ur orders"),
            ));
          }
        },
        builder: (context, state) {
          HomeCubit cubit = BlocProvider.of(context);
          List<HomeModel> products = query != null
              ? cubit.searchProducts
              : category != null
                  ? cubit.categoriesProducts
                  : isFav
                      ? cubit.favList
                      : isOrder
                          ? cubit.ordersList
                          : cubit.products;
          return SizedBox(
            child: ListView.separated(
                shrinkWrap: wrap ?? true,
                physics: physics ?? NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return CustomContainer(
                    model: products[index],
                    onPressed: () {
                      bool isFav = cubit.checkFav(products[index].productId!);
                      isFav
                          ? cubit.removeFav(products[index].productId!)
                          : cubit.addToFav(products[index].productId!);
                    },
                    isFav: cubit.checkFav(products[index].productId!),
                    onPaymentSuccess: () {
                      cubit.buyProduct(productId: products[index].productId!);
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemCount: products.length),
          );
        },
      ),
    );
  }
}
