import 'dart:convert';

GetCartCountResponse getCartCountResponseFromJson(String str) =>
    GetCartCountResponse.fromJson(json.decode(str));

String getCartCountResponseToJson(GetCartCountResponse data) =>
    json.encode(data.toJson());

class GetCartCountResponse {
  GetCartCountResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  Data? data;

  factory GetCartCountResponse.fromJson(Map<String, dynamic> json) =>
      GetCartCountResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data!.toJson(),
      };
}

class Data {
  Data({
    required this.sumOfQty,
  });

  int sumOfQty;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sumOfQty: json["SumOfQty"],
      );

  Map<String, dynamic> toJson() => {
        "SumOfQty": sumOfQty,
      };
}
