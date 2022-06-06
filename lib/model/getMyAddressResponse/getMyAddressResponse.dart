import 'dart:convert';

GetMyAddressResponse getMyAddressResponseFromJson(String str) => GetMyAddressResponse.fromJson(json.decode(str));

String getMyAddressResponseToJson(GetMyAddressResponse data) => json.encode(data.toJson());

class GetMyAddressResponse {
    GetMyAddressResponse({
        this.statusCode,
        this.message,
        this.data,
    });

    int ?statusCode;
    String ?message;
    List<GetMyAddressData> ?data;

    factory GetMyAddressResponse.fromJson(Map<String, dynamic> json) => GetMyAddressResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: List<GetMyAddressData>.from(json["Data"].map((x) => GetMyAddressData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class GetMyAddressData {
    GetMyAddressData({
        this.id,
        this.userId,
        this.mobileNo,
        this.deviceId,
        this.fullName,
        this.addressLine1,
        this.addressLine2,
        this.landmark,
        this.city,
        this.state,
        this.pinCode,
        this.addressType,
        this.isdefault,
        this.isActive,
        this.createdOn,
        this.updatedOn,
        this.isDelete,
        this.isServiceable,
    });

    int ?id;
    String ?userId;
    String ?mobileNo;
    String ?deviceId;
    String ?fullName;
    String ?addressLine1;
    String ?addressLine2;
    String ?landmark;
    String ?city;
    String ?state;
    String ?pinCode;
    String ?addressType;
    bool ?isdefault;
    bool ?isActive;
    DateTime ?createdOn;
    DateTime ?updatedOn;
    bool ?isDelete;
    bool ?isServiceable;

    factory GetMyAddressData.fromJson(Map<String, dynamic> json) => GetMyAddressData(
        id: json["Id"],
        userId: json["UserId"],
        mobileNo: json["MobileNo"],
        deviceId: json["DeviceId"],
        fullName: json["FullName"],
        addressLine1: json["AddressLine1"],
        addressLine2: json["AddressLine2"],
        landmark: json["Landmark"],
        city: json["City"],
        state: json["State"],
        pinCode: json["PinCode"],
        addressType: json["AddressType"],
        isdefault: json["Isdefault"],
        isActive: json["IsActive"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        updatedOn: DateTime.parse(json["UpdatedOn"]),
        isDelete: json["IsDelete"],
        isServiceable: json["IsServiceable"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "UserId": userId,
        "MobileNo": mobileNo,
        "DeviceId": deviceId,
        "FullName": fullName,
        "AddressLine1": addressLine1,
        "AddressLine2": addressLine2,
        "Landmark": landmark,
        "City": city,
        "State": state,
        "PinCode": pinCode,
        "AddressType": addressType,
        "Isdefault": isdefault,
        "IsActive": isActive,
        "CreatedOn": createdOn!.toIso8601String(),
        "UpdatedOn": updatedOn!.toIso8601String(),
        "IsDelete": isDelete,
        "IsServiceable": isServiceable,
    };
}
