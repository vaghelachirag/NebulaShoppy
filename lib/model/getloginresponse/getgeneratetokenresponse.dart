// To parse this JSON data, do
//
//     final getGenerateTokenresponse = getGenerateTokenresponseFromJson(jsonString);

import 'dart:convert';

GetGenerateTokenresponse getGenerateTokenresponseFromJson(String str) => GetGenerateTokenresponse.fromJson(json.decode(str));

String getGenerateTokenresponseToJson(GetGenerateTokenresponse data) => json.encode(data.toJson());

class GetGenerateTokenresponse {
    GetGenerateTokenresponse({
        required this.accessToken,
        required this.tokenType,
        required this.expiresIn,
       required this.refreshToken,
      required  this.userName,
       required this.iboKeyId,
      required  this.role,
       required this.displayName,
       required this.encryptUserName,
       required this.issued,
       required this.expires,
    });

    String accessToken;
    String tokenType;
    int expiresIn;
    String refreshToken;
    String userName;
    String iboKeyId;
    String role;
    String displayName;
    String encryptUserName;
    String issued;
    String expires;

    factory GetGenerateTokenresponse.fromJson(Map<String, dynamic> json) => GetGenerateTokenresponse(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        refreshToken: json["refresh_token"],
        userName: json["UserName"],
        iboKeyId: json["IBOKeyId"],
        role: json["Role"],
        displayName: json["DisplayName"],
        encryptUserName: json["EncryptUserName"],
        issued: json[".issued"],
        expires: json[".expires"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "refresh_token": refreshToken,
        "UserName": userName,
        "IBOKeyId": iboKeyId,
        "Role": role,
        "DisplayName": displayName,
        "EncryptUserName": encryptUserName,
        ".issued": issued,
        ".expires": expires,
    };
}
