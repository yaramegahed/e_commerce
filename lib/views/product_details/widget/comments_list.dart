import 'package:e_commerce/core/models/home_model.dart';
import 'package:e_commerce/views/product_details/logic/cubit/product_details_cubit.dart';
import 'package:e_commerce/views/product_details/logic/model/comments_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommentsList extends StatelessWidget {

  const CommentsList({super.key, required this.model, this.commentsModel});

  final CommentsModel? commentsModel;
  final HomeModel? model;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if(state is GetCommentLoadingState){
            CircularProgressIndicator();
          }

        },
        builder: (context, state) {
          ProductDetailsCubit cubit=BlocProvider.of(context);
          return StreamBuilder(
            stream: Supabase.instance.client
                .from("comments")
                .stream(primaryKey: ["id"])
                .eq("for_product", model?.productId??"")
                .order("created_at"),
            builder: (context, snapshot) {
              List<Map<String, dynamic>>? data = snapshot.data;
              print(snapshot.data);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              cubit.comments[index].userName ?? "User Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(cubit.comments[index].comment ?? "no comment"),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              commentsModel?.userName ?? "User Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(commentsModel?.replay ?? "no replay"),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 5,
                    );
                  },
                  itemCount:data!.length,
                );
              } else if (!snapshot.hasData) {
                return Center(child: Text("no comments"));
              } else {
                return Text("something went wrong");
              }
            },
          );
        },
      ),
    );
  }
}
