import 'dart:convert';

GetProductBannerImageResponse getProductBannerImageResponseFromJson(String str) => GetProductBannerImageResponse.fromJson(json.decode(str));

String getProductBannerImageResponseToJson(GetProductBannerImageResponse data) => json.encode(data.toJson());

class GetProductBannerImageResponse {
    GetProductBannerImageResponse({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    int statusCode;
    String message;
    List<GetProductBannerData> data;

    factory GetProductBannerImageResponse.fromJson(Map<String, dynamic> json) => GetProductBannerImageResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: List<GetProductBannerData>.from(json["Data"].map((x) => GetProductBannerData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class GetProductBannerData {
    GetProductBannerData({
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

    factory GetProductBannerData.fromJson(Map<String, dynamic> json) => GetProductBannerData(
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
