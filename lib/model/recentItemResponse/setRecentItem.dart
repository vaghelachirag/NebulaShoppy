import 'dart:convert';

SetRecentItemResponse setRecentItemResponseFromJson(String str) =>
    SetRecentItemResponse.fromJson(json.decode(str));

String setRecentItemResponseToJson(SetRecentItemResponse data) =>
    json.encode(data.toJson());

class SetRecentItemResponse {
  SetRecentItemResponse({
    required this.id,
    required this.productName,
    required this.categorySaleprice,
    required this.productImage,
    required this.productId,
    required this.quantity,
    required this.ecbId,
  });

  int id;
  String productName;
  String categorySaleprice;
  String productImage;
  String productId;
  String quantity;
  String ecbId;

  factory SetRecentItemResponse.fromJson(Map<String, dynamic> json) =>
      SetRecentItemResponse(
        id: json["id"],
        productName: json["productName"],
        categorySaleprice: json["categorySaleprice"],
        productImage: json["productImage"],
        productId: json["productId"],
        quantity: json["quantity"],
        ecbId: json["ecbId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productName": productName,
        "categorySaleprice": categorySaleprice,
        "productImage": productImage,
        "productId": productId,
        "quantity": quantity,
        "ecbId": ecbId,
      };
}
