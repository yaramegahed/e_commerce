class CommentsModel {
  CommentsModel({
    required this.id,
    required this.createdAt,
    required this.comment,
    required this.forUser,
    required this.forProduct,
    required this.userName,
    required this.replay,
  });

  final String? id;
  final DateTime? createdAt;
  final String? comment;
  final String? forUser;
  final String? forProduct;
  final String? userName;
  final String? replay;

  factory CommentsModel.fromJson(Map<String, dynamic> json){
    return CommentsModel(
      id: json["id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      comment: json["comment"],
      forUser: json["for_user"],
      forProduct: json["for_product"],
      userName: json["user_name"],
      replay: json["replay"],
    );
  }

}
