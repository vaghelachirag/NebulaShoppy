import 'dart:convert';

GetCartTotalResponse getCartTotalResponseFromJson(String str) =>
    GetCartTotalResponse.fromJson(json.decode(str));

String getCartTotalResponseToJson(GetCartTotalResponse data) =>
    json.encode(data.toJson());

class GetCartTotalResponse {
  GetCartTotalResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  GetCartTotalData? data;

  factory GetCartTotalResponse.fromJson(Map<String, dynamic> json) =>
      GetCartTotalResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: GetCartTotalData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data!.toJson(),
      };
}

class GetCartTotalData {
  GetCartTotalData({
    this.sumOfQty,
  });

  int? sumOfQty;

  factory GetCartTotalData.fromJson(Map<String, dynamic> json) =>
      GetCartTotalData(
        sumOfQty: json["SumOfQty"],
      );

  Map<String, dynamic> toJson() => {
        "SumOfQty": sumOfQty,
      };
}
