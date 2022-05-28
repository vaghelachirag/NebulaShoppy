import 'dart:convert';

GetAddToCartResponse getAddToCartResponseFromJson(String str) => GetAddToCartResponse.fromJson(json.decode(str));

String getAddToCartResponseToJson(GetAddToCartResponse data) => json.encode(data.toJson());

class GetAddToCartResponse {
    GetAddToCartResponse({
        this.statusCode,
        this.message,
        this.data,
    });

    int ?statusCode;
    String ?message;
    int ?data;

    factory GetAddToCartResponse.fromJson(Map<String, dynamic> json) => GetAddToCartResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: json["Data"],
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data,
    };
}
