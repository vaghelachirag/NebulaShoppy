
import 'dart:convert';

GetCityByStateResponse getCityByStateResponseFromJson(String str) => GetCityByStateResponse.fromJson(json.decode(str));

String getCityByStateResponseToJson(GetCityByStateResponse data) => json.encode(data.toJson());

class GetCityByStateResponse {
    GetCityByStateResponse({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    int statusCode;
    String message;
    List<getCityByStateData> data;

    factory GetCityByStateResponse.fromJson(Map<String, dynamic> json) => GetCityByStateResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: List<getCityByStateData>.from(json["Data"].map((x) => getCityByStateData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class getCityByStateData {
    getCityByStateData({
        required this.stateId,
        required this.cityId,
        required this.cityName,
    });

    int stateId;
    int cityId;
    String cityName;

    factory getCityByStateData.fromJson(Map<String, dynamic> json) => getCityByStateData(
        stateId: json["StateId"],
        cityId: json["CityId"],
        cityName: json["CityName"],
    );

    Map<String, dynamic> toJson() => {
        "StateId": stateId,
        "CityId": cityId,
        "CityName": cityName,
    };
}
