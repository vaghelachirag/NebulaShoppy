import 'dart:convert';

GetRegisterFcmResponse getRegisterFcmResponseFromJson(String str) => GetRegisterFcmResponse.fromJson(json.decode(str));

String getRegisterFcmResponseToJson(GetRegisterFcmResponse data) => json.encode(data.toJson());

class GetRegisterFcmResponse {
    GetRegisterFcmResponse({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    int statusCode;
    String message;
    GetRegisterFcmData data;

    factory GetRegisterFcmResponse.fromJson(Map<String, dynamic> json) => GetRegisterFcmResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: GetRegisterFcmData.fromJson(json["Data"]),
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data.toJson(),
    };
}

class GetRegisterFcmData {
    GetRegisterFcmData({
        required this.tokenKey,
        this.deviceId,
        required this.imei1,
        required this.imei2,
        required this.userId,
        this.createdUser,
        required this.createdOn,
        required this.updatedOn,
        this.lastLoginOn,
        required this.isDelete,
        required this.id,
    });

    String tokenKey;
    dynamic deviceId;
    String imei1;
    String imei2;
    String userId;
    dynamic createdUser;
    DateTime createdOn;
    DateTime updatedOn;
    dynamic lastLoginOn;
    bool isDelete;
    int id;

    factory GetRegisterFcmData.fromJson(Map<String, dynamic> json) => GetRegisterFcmData(
        tokenKey: json["TokenKey"],
        deviceId: json["DeviceId"],
        imei1: json["IMEI1"],
        imei2: json["IMEI2"],
        userId: json["UserId"],
        createdUser: json["CreatedUser"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        updatedOn: DateTime.parse(json["UpdatedOn"]),
        lastLoginOn: json["LastLoginOn"],
        isDelete: json["IsDelete"],
        id: json["Id"],
    );

    Map<String, dynamic> toJson() => {
        "TokenKey": tokenKey,
        "DeviceId": deviceId,
        "IMEI1": imei1,
        "IMEI2": imei2,
        "UserId": userId,
        "CreatedUser": createdUser,
        "CreatedOn": createdOn.toIso8601String(),
        "UpdatedOn": updatedOn.toIso8601String(),
        "LastLoginOn": lastLoginOn,
        "IsDelete": isDelete,
        "Id": id,
    };
}
