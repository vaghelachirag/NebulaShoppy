import 'dart:convert';

Itembannerimage itembannerimageFromJson(String str) =>
    Itembannerimage.fromJson(json.decode(str));

String itembannerimageToJson(Itembannerimage data) =>
    json.encode(data.toJson());

class Itembannerimage {
  Itembannerimage({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  List<ItembannerimageData> data;

  factory Itembannerimage.fromJson(Map<String, dynamic> json) =>
      Itembannerimage(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: List<ItembannerimageData>.from(
            json["Data"].map((x) => ItembannerimageData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ItembannerimageData {
  ItembannerimageData({
    required this.id,
    required this.name,
    required this.productId,
    required this.imageFile,
    required this.description,
  });

  int id;
  String name;
  int productId;
  String imageFile;
  String description;

  factory ItembannerimageData.fromJson(Map<String, dynamic> json) =>
      ItembannerimageData(
        id: json["Id"],
        name: json["Name"],
        productId: json["ProductId"],
        imageFile: json["ImageFile"],
        description: json["Description"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "ProductId": productId,
        "ImageFile": imageFile,
        "Description": description,
      };
}
