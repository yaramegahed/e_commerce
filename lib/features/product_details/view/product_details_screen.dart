import 'package:e_commerce/core/models/home_model.dart';
import 'package:e_commerce/core/widget/custom_app_bar.dart';
import 'package:e_commerce/core/widget/custom_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';

import '../../../core/widget/cashed_image.dart';
import '../../auth/logic/cubit/auth_cubit.dart';
import '../logic/cubit/product_details_cubit.dart';
import '../logic/model/comments_model.dart';
import '../widget/comments_list.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, this.model, this.commentsModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
  final HomeModel? model;
  final CommentsModel? commentsModel;
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final TextEditingController commentController = TextEditingController();
  double rating = 3.5;
  int starCount = 5;

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailsCubit()..getRate(productId: widget.model!.productId!),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          // if (state is GetRateLoadingState ||
          //     state is PostCommentLoadingState) {
          //   CircularProgressIndicator();
          // }
          if (state is GetRateSuccessState) {}
          // if (state is PatchRateSuccessState) {
          //   Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => widget,
          //       ));
          // }
        },
        builder: (context, state) {
          ProductDetailsCubit cubit = BlocProvider.of(context);
          return Scaffold(
            appBar: CustomAppBar(
              title: "${widget.model?.productName ?? "no name"}  ",
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  CashedImage(
                    url: widget.model?.images ?? "no image",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.model?.productName ?? "Product Name",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${widget.model?.price ?? "no price"} LE",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              widget.model?.description ?? "Product Name",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              cubit.averageRate.toString(),
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 30,
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.grey,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Product Rate",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        StarRating(
                          size: 40.0,
                          color: Colors.amber,
                          borderColor: Colors.grey,
                          allowHalfRating: true,
                          rating: rating ,
                          starCount: starCount,
                          onRatingChanged: (rating) => setState(() {
                            this.rating = rating;
                            if (kDebugMode) {
                              print(rating);
                            }
                            cubit.patchRate(
                                productId: widget.model?.productId ?? "no rate",
                                getData: {
                                  "rate": rating,
                                  "for_user": cubit.userId,
                                  "for_product": widget.model?.productId
                                });
                          }),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          controller: commentController,
                          label: "Type your feedback",
                          hint: "Type your feedback",
                          suffixIcon: Icons.send,
                          onTap: () async {
                            await context.read<AuthCubit>().getData();
                            await cubit.addComment(getData: {
                              "comment": commentController.text,
                              "for_user": cubit.userId,
                              "for_product": widget.model?.productId,
                              "user_name": context.read<AuthCubit>()
                                      .userDataModel
                                      ?.name ??
                                  "no name",
                              "replay": null
                            });
                            commentController.clear();
                          },
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              "Comments",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CommentsList(
                          model: widget.model!,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
