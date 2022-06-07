import 'dart:convert';

GetstateResponse getstateResponseFromJson(String str) => GetstateResponse.fromJson(json.decode(str));

String getstateResponseToJson(GetstateResponse data) => json.encode(data.toJson());

class GetstateResponse {
    GetstateResponse({
        this.statusCode,
        this.message,
        this.data,
    });

    int ?statusCode;
    String ?message;
    List<GetstateData> ?data;

    factory GetstateResponse.fromJson(Map<String, dynamic> json) => GetstateResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: List<GetstateData>.from(json["Data"].map((x) => GetstateData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class GetstateData {
    GetstateData({
        this.countryId,
        this.stateId,
        this.stateName,
    });

    int ?countryId;
    int ?stateId;
    String ?stateName;

    factory GetstateData.fromJson(Map<String, dynamic> json) => GetstateData(
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
