import 'dart:convert';

GetdeleteaddressResponse getdeleteaddressResponseFromJson(String str) => GetdeleteaddressResponse.fromJson(json.decode(str));

String getdeleteaddressResponseToJson(GetdeleteaddressResponse data) => json.encode(data.toJson());

class GetdeleteaddressResponse {
    GetdeleteaddressResponse({
        this.statusCode,
        this.message,
        this.data,
    });

    int ?statusCode;
    String ?message;
    int ?data;

    factory GetdeleteaddressResponse.fromJson(Map<String, dynamic> json) => GetdeleteaddressResponse(
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
