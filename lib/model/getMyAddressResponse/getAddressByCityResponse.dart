import 'dart:convert';

GetAddressByCityResponse getAddressByCityResponseFromJson(String str) => GetAddressByCityResponse.fromJson(json.decode(str));

String getAddressByCityResponseToJson(GetAddressByCityResponse data) => json.encode(data.toJson());

class GetAddressByCityResponse {
    GetAddressByCityResponse({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    int statusCode;
    String message;
    List<GetAddressByCityData> data;

    factory GetAddressByCityResponse.fromJson(Map<String, dynamic> json) => GetAddressByCityResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: List<GetAddressByCityData>.from(json["Data"].map((x) => GetAddressByCityData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class GetAddressByCityData {
    GetAddressByCityData({
        required this.id,
        required this.address,
        required this.facility,
    });

    int id;
    String address;
    String facility;

    factory GetAddressByCityData.fromJson(Map<String, dynamic> json) => GetAddressByCityData(
        id: json["Id"],
        address: json["Address"],
        facility: json["Facility"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Address": address,
        "Facility": facility,
    };
}
