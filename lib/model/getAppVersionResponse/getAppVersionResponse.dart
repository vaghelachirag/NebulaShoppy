import 'dart:convert';

GetAppVersionResponse getAppVersionResponseFromJson(String str) => GetAppVersionResponse.fromJson(json.decode(str));

String getAppVersionResponseToJson(GetAppVersionResponse data) => json.encode(data.toJson());

class GetAppVersionResponse {
    GetAppVersionResponse({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    int statusCode;
    String message;
    String data;

    factory GetAppVersionResponse.fromJson(Map<String, dynamic> json) => GetAppVersionResponse(
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
