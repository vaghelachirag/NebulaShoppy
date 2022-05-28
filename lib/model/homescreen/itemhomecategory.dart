
import 'dart:convert';

Itemhomecategory itemhomecategoryFromJson(String str) => Itemhomecategory.fromJson(json.decode(str));

String itemhomecategoryToJson(Itemhomecategory data) => json.encode(data.toJson());

class Itemhomecategory {
    Itemhomecategory({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    int statusCode;
    String message;
    List<HomeCategoryData> data;

    factory Itemhomecategory.fromJson(Map<String, dynamic> json) => Itemhomecategory(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: List<HomeCategoryData>.from(json["Data"].map((x) => HomeCategoryData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class HomeCategoryData {
    HomeCategoryData({
        required this.id,
        required this.name,
        required this.description,
        required this.displayOrder,
        required this.image,
    });

    int id;
    String name;
    String description;
    int displayOrder;
    String image;

    factory HomeCategoryData.fromJson(Map<String, dynamic> json) => HomeCategoryData(
        id: json["Id"],
        name: json["Name"],
        description: json["Description"],
        displayOrder: json["DisplayOrder"],
        image: json["Image"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Description": description,
        "DisplayOrder": displayOrder,
        "Image": image,
    };
}
