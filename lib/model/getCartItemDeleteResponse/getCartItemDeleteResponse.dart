import 'dart:convert';

GetDeleteCartResponse getDeleteCartResponseFromJson(String str) => GetDeleteCartResponse.fromJson(json.decode(str));

String getDeleteCartResponseToJson(GetDeleteCartResponse data) => json.encode(data.toJson());

class GetDeleteCartResponse {
    GetDeleteCartResponse({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    int statusCode;
    String message;
    GetDeleteCartData data;

    factory GetDeleteCartResponse.fromJson(Map<String, dynamic> json) => GetDeleteCartResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: GetDeleteCartData.fromJson(json["Data"]),
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data.toJson(),
    };
}

class GetDeleteCartData {
    GetDeleteCartData({
        required this.itemsDeleted,
    });

    int itemsDeleted;

    factory GetDeleteCartData.fromJson(Map<String, dynamic> json) => GetDeleteCartData(
        itemsDeleted: json["ItemsDeleted"],
    );

    Map<String, dynamic> toJson() => {
        "ItemsDeleted": itemsDeleted,
    };
}
