import 'dart:convert';

GetstatelistResponse getstatelistResponseFromJson(String str) => GetstatelistResponse.fromJson(json.decode(str));

String getstatelistResponseToJson(GetstatelistResponse data) => json.encode(data.toJson());

class GetstatelistResponse {
    GetstatelistResponse({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    int statusCode;
    String message;
    List<GetStateListData> data;

    factory GetstatelistResponse.fromJson(Map<String, dynamic> json) => GetstatelistResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: List<GetStateListData>.from(json["Data"].map((x) => GetStateListData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class GetStateListData {
    GetStateListData({
        required this.countryId,
        required this.stateId,
        required this.stateName,
    });

    int countryId;
    int stateId;
    String stateName;

    factory GetStateListData.fromJson(Map<String, dynamic> json) => GetStateListData(
        countryId: json["CountryId"],
        stateId: json["StateId"],
        stateName: json["StateName"],
    );

    Map<String, dynamic> toJson() => {
        "CountryId": countryId,
        "StateId": stateId,
        "StateName": stateName,
    };
}
