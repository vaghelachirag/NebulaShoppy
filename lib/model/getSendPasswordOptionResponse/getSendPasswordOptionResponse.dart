import 'dart:convert';

GetSendPasswordOptionResponse getSendPasswordOptionResponseFromJson(String str) => GetSendPasswordOptionResponse.fromJson(json.decode(str));

String getSendPasswordOptionResponseToJson(GetSendPasswordOptionResponse data) => json.encode(data.toJson());

class GetSendPasswordOptionResponse {
    GetSendPasswordOptionResponse({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    int statusCode;
    String message;
    Data data;

    factory GetSendPasswordOptionResponse.fromJson(Map<String, dynamic> json) => GetSendPasswordOptionResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data.toJson(),
    };
}

class Data {
    Data({
        this.id,
        required this.email,
        required this.mobile,
        this.code,
    });

    dynamic id;
    String email;
    String mobile;
    dynamic code;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["Id"],
        email: json["Email"],
        mobile: json["Mobile"],
        code: json["Code"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Email": email,
        "Mobile": mobile,
        "Code": code,
    };
}
