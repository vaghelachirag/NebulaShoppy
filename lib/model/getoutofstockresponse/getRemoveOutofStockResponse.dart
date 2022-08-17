import 'dart:convert';

GetRemoveProductFromCartResponse getRemoveProductFromCartResponseFromJson(String str) => GetRemoveProductFromCartResponse.fromJson(json.decode(str));

String getRemoveProductFromCartResponseToJson(GetRemoveProductFromCartResponse data) => json.encode(data.toJson());

class GetRemoveProductFromCartResponse {
    GetRemoveProductFromCartResponse({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    int statusCode;
    String message;
    String data;

    factory GetRemoveProductFromCartResponse.fromJson(Map<String, dynamic> json) => GetRemoveProductFromCartResponse(
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
