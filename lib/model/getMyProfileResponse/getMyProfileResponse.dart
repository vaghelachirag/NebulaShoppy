import 'dart:convert';

GetMyProfileResponse getMyProfileResponseFromJson(String str) => GetMyProfileResponse.fromJson(json.decode(str));

String getMyProfileResponseToJson(GetMyProfileResponse data) => json.encode(data.toJson());

class GetMyProfileResponse {
    GetMyProfileResponse({
        this.statusCode,
        this.message,
        this.data,
    });

    int ?statusCode;
    String ?message;
    GetMyProfileData ?data;

    factory GetMyProfileResponse.fromJson(Map<String, dynamic> json) => GetMyProfileResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: GetMyProfileData.fromJson(json["Data"]),
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data!.toJson(),
    };
}

class GetMyProfileData {
    GetMyProfileData({
        this.id,
        this.username,
        this.firstName,
        this.lastName,
        this.mobile,
        this.email,
        this.gender,
    });

    String ?id;
    String ?username;
    String ?firstName;
    String ?lastName;
    String ?mobile;
    String ?email;
    String ?gender;

    factory GetMyProfileData.fromJson(Map<String, dynamic> json) => GetMyProfileData(
        id: json["Id"],
        username: json["Username"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        mobile: json["Mobile"],
        email: json["Email"],
        gender: json["Gender"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Username": username,
        "FirstName": firstName,
        "LastName": lastName,
        "Mobile": mobile,
        "Email": email,
        "Gender": gender,
    };
}
