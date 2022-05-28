// To parse this JSON data, do
//
//     final productBanner = productBannerFromJson(jsonString);

import 'dart:convert';

ProductBanner productBannerFromJson(String str) =>
    ProductBanner.fromJson(json.decode(str));

String productBannerToJson(ProductBanner data) => json.encode(data.toJson());

class ProductBanner {
  ProductBanner({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  List<ProductBannerData> data;

  factory ProductBanner.fromJson(Map<String, dynamic> json) => ProductBanner(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: List<ProductBannerData>.from(
            json["Data"].map((x) => ProductBannerData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ProductBannerData {
  ProductBannerData({
    required this.id,
    required this.name,
    required this.hqImageFile,
    required this.imageFile,
    required this.imagePath,
    required this.description,
  });

  int id;
  String name;
  String hqImageFile;
  String imageFile;
  String imagePath;
  String description;

  factory ProductBannerData.fromJson(Map<String, dynamic> json) =>
      ProductBannerData(
        id: json["Id"],
        name: json["Name"],
        hqImageFile: json["HQImageFile"],
        imageFile: json["ImageFile"],
        imagePath: json["ImagePath"],
        description: json["Description"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "HQImageFile": hqImageFile,
        "ImageFile": imageFile,
        "ImagePath": imagePath,
        "Description": description,
      };
}
