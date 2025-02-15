import 'package:bloc/bloc.dart';
import 'package:e_commerce/core/api_services/api_services.dart';
import 'package:e_commerce/core/models/home_model.dart';
import 'package:flutter/foundation.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  ApiServices data = ApiServices();
  List<HomeModel> products = [];

  Future<void> getProducts() async {
    emit(GetDataLoadingState());
    try {
      var response = await data
          .getData("products?select=*,favorite_products(*),purchase()*");
      for(var product in response.data as List){
        products.add(HomeModel.fromJson(product));
      }
      if (kDebugMode) {
        print(response);
      }
      emit(GetDataSuccessState());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(GetDataErrorState());
    }
  }
}
