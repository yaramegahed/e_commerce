class RateModel {
  RateModel({
    required this.id,
    required this.createdAt,
    required this.rate,
    required this.forUser,
    required this.forProduct,
  });

  final String? id;
  final DateTime? createdAt;
  final num? rate;
  final String? forUser;
  final String? forProduct;

  factory RateModel.fromJson(Map<String, dynamic> json){
    return RateModel(
      id: json["id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      rate: json["rate"],
      forUser: json["for_user"],
      forProduct: json["for_product"],
    );
  }

}
