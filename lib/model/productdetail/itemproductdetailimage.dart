// To parse this JSON data, do
//
//     final itemProductDetailImage = itemProductDetailImageFromJson(jsonString);

import 'dart:convert';

ItemProductDetailImage itemProductDetailImageFromJson(String str) =>
    ItemProductDetailImage.fromJson(json.decode(str));

String itemProductDetailImageToJson(ItemProductDetailImage data) =>
    json.encode(data.toJson());

class ItemProductDetailImage {
  ItemProductDetailImage({
    this.statusCode,
    this.message,
    required this.data,
  });

  int? statusCode;
  String? message;
  List<itemproductimageData> data;

  factory ItemProductDetailImage.fromJson(Map<String, dynamic> json) =>
      ItemProductDetailImage(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: List<itemproductimageData>.from(
            json["Data"].map((x) => itemproductimageData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class itemproductimageData {
  itemproductimageData({
    this.id,
    this.imageFile,
    this.isDelete,
  });

  int? id;
  String? imageFile;
  bool? isDelete;

  factory itemproductimageData.fromJson(Map<String, dynamic> json) =>
      itemproductimageData(
        id: json["Id"],
        imageFile: json["ImageFile"],
        isDelete: json["IsDelete"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ImageFile": imageFile,
        "IsDelete": isDelete,
      };
}
