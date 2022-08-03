import 'dart:convert';

GetMyWalletResponse getMyWalletResponseFromJson(String str) =>
    GetMyWalletResponse.fromJson(json.decode(str));

String getMyWalletResponseToJson(GetMyWalletResponse data) =>
    json.encode(data.toJson());

class GetMyWalletResponse {
  GetMyWalletResponse({
    this.statusCode,
    this.message,
    required this.data,
  });

  int? statusCode;
  String? message;
  dynamic data;

  factory GetMyWalletResponse.fromJson(Map<String, dynamic> json) =>
      GetMyWalletResponse(
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
