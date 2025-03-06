import 'package:e_commerce/core/models/home_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../logic/cubit/product_details_cubit.dart';
import '../logic/model/comments_model.dart';

class CommentsList extends StatelessWidget {
  CommentsList({super.key, required this.model, this.commentsModel});

  final CommentsModel? commentsModel;
  final HomeModel model;

  final List<CommentsModel> comments = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state is GetCommentLoadingState) {
            CircularProgressIndicator();
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return StreamBuilder(
            stream: Supabase.instance.client
                .from("comments")
                .stream(primaryKey: ["id"])
                .eq("for_product", model.productId!)
                .order("created_at"),
            builder: (context, snapshot) {
              List<Map<String, dynamic>>? data = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var commentData = data?[index];
                    if (kDebugMode) {
                      print(commentData);
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                commentData?["user_name"] ?? "no user",
                                // cubit.comments[index].userName ?? "User Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(commentData?["comment"] ?? "no comment"),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          commentData?["replay"] !=null && commentData!["replay"].toString().isNotEmpty?
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Text(
                                  commentData["user_name"] ?? "no user",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.blueAccent),
                                ),
                                SizedBox(
                                  width: 10,
                                ),

                                Text(commentData["replay"] ?? "no replay"),
                              ],
                            ),
                          ):SizedBox.shrink(),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 5,
                    );
                  },
                  itemCount: data?.length ?? 10,
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
