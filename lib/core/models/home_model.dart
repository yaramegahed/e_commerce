class HomeModel {
  HomeModel({
    required this.productId,
    required this.createdAt,
    required this.productName,
    required this.price,
    required this.oldPrice,
    required this.sale,
    required this.description,
    required this.category,
    required this.images,
    required this.favoriteProducts,
  });

  final String? productId;
  final DateTime? createdAt;
  final String? productName;
  final String? price;
  final String? oldPrice;
  final String? sale;
  final String? description;
  final String? category;
  final dynamic images;
  final List<FavoriteProduct> favoriteProducts;

  factory HomeModel.fromJson(Map<String, dynamic> json){
    return HomeModel(
      productId: json["product_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      productName: json["product_name"],
      price: json["price"],
      oldPrice: json["old_price"],
      sale: json["sale"],
      description: json["description"],
      category: json["category"],
      images: json["images"],
      favoriteProducts: json["favorite_products"] == null ? [] : List<FavoriteProduct>.from(json["favorite_products"]!.map((x) => FavoriteProduct.fromJson(x))),
    );
  }

}

class FavoriteProduct {
  FavoriteProduct({
    required this.id,
    required this.isFav,
    required this.forUser,
    required this.createdAt,
    required this.forProduct,
  });

  final String? id;
  final bool? isFav;
  final String? forUser;
  final DateTime? createdAt;
  final String? forProduct;

  factory FavoriteProduct.fromJson(Map<String, dynamic> json){
    return FavoriteProduct(
      id: json["id"],
      isFav: json["is_fav"],
      forUser: json["for_user"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      forProduct: json["for_product"],
    );
  }

}
