import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/core/api_services/api_services.dart';
import 'package:e_commerce/views/product_details/logic/model/comments_model.dart';
import 'package:e_commerce/views/product_details/logic/model/rate_model.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  SupabaseClient client = Supabase.instance.client;
  ApiServices data = ApiServices();
  List<RateModel> rates = [];
  List<CommentsModel> comments = [];
  num averageRate = 0;
  num userRates = 5;
  String userId = Supabase.instance.client.auth.currentUser!.id;

  Future<void> getRate({required String productId}) async {
    emit(GetRateLoadingState());
    try {
      Response response =
          await data.getData("rate?select=*&for_product=eq.$productId");
      for (var rate in response.data) {
        rates.add(RateModel.fromJson(rate));
      }
      for (var userRate in rates) {
        averageRate += userRate.rate ?? 0;
      }
      if (rates.isNotEmpty) {
        averageRate = averageRate ~/ rates.length;
      }

      if (kDebugMode) {
        print(averageRate);
      }
      List<RateModel> userRates =
          rates.where((rate) => rate.forUser == userId).toList();
      if (kDebugMode) {
        print(rates[0].rate);
      }
      emit(GetRateSuccessState());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(GetRateErrorState());
    }
  }

  bool checkUserRate({required String productId}) {
    for (var rate in rates) {
      if ((rate.forUser == userId) && (rate.forProduct == productId)) {
        return true;
      }
    }
    return false;
  }

  Future<void> patchRate(
      {required String productId,
      required Map<String, dynamic> getData}) async {
    String path = "rate?select=*&for_user=eq.$userId&for_product=eq.$productId";
    emit(PatchRateLoadingState());
    try {
      if (checkUserRate(productId: productId)) {
        await data.patchData(path, getData);
      } else {
        await data.postData(path, getData);
      }
      emit(PatchRateSuccessState());
    } catch (e) {
      print(e);
      emit(PatchRateErrorState());
    }
  }

  Future<void> addComment({required Map<String, dynamic> getData}) async {
    emit(PostCommentLoadingState());
    try {
      await data.postData("comments", getData);
      emit(PostCommentSuccessState());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(PostCommentErrorState());
    }
  }

  Future<void> getComment() async {
    emit(GetRateLoadingState());
    try {
      await data.getData(
        "comments",
      );
      emit(GetCommentSuccessState());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(GetRateErrorState());
    }
  }

  CommentsModel? commentsModel;

  Future<void> getComments({required String productId}) async {
    emit(GetCommentLoadingState());
    try {
      final response = await data.getData("comments");
      if (response is List) {
        comments.clear();
        for (var comment in response.data) {
          comments.add(CommentsModel.fromJson(comment));
        }
        emit(GetCommentSuccessState());
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      print("Error fetching comments: $e");
      emit(GetCommentErrorState());
    }
  }

}
