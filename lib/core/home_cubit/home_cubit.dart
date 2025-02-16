import 'package:bloc/bloc.dart';
import 'package:e_commerce/core/api_services/api_services.dart';
import 'package:e_commerce/core/models/home_model.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  ApiServices data = ApiServices();
  List<HomeModel> products = [];
  List<HomeModel> searchProducts = [];
  List<HomeModel> categoriesProducts = [];
  final String userId=Supabase.instance.client.auth.currentUser!.id;

  Future<void> getProducts({String? query, String? category}) async {
    emit(GetDataLoadingState());
    try {
      var response = await data
          .getData("products?select=*,favorite_products(*),purchase()*");
      for (var product in response.data as List) {
        products.add(HomeModel.fromJson(product));
      }
      if (kDebugMode) {
        print(response);
      }
      search(query);
      searchByCategory(category);
      emit(GetDataSuccessState());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(GetDataErrorState());
    }
  }

  void search(String? query) {
    if (query != null) {
      for (var product in products) {
        if (product.productName!.toLowerCase().contains(query.toLowerCase())) {
          searchProducts.add(product);
        }
      }
    }
  }

  void searchByCategory(String? category) {
    if (category != null) {
      for (var product in products) {
        if (product.category!.trim().toLowerCase() ==
            category.trim().toLowerCase()) {
          categoriesProducts.add(product);
        }
      }
    }
  }

  Future<void> addToFav(String productId) async {
    emit(AddToFavLoadingState());
    try {
      await data.postData("favorite_products", {
        "is_fav":"true",
        "for_user":userId,
        "for_products":productId,
      });
      emit(AddToFavSuccessState());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(AddToFavErrorState());
    }
  }
}
