import 'dart:convert';

GetTrackOrderResponse getTrackOrderResponseFromJson(String str) => GetTrackOrderResponse.fromJson(json.decode(str));

String getTrackOrderResponseToJson(GetTrackOrderResponse data) => json.encode(data.toJson());

class GetTrackOrderResponse {
    GetTrackOrderResponse({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    int statusCode;
    String message;
    GetTrackOrderData data;

    factory GetTrackOrderResponse.fromJson(Map<String, dynamic> json) => GetTrackOrderResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: GetTrackOrderData.fromJson(json["Data"]),
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data.toJson(),
    };
}

class GetTrackOrderData {
    GetTrackOrderData({
        required this.trackingData,
    });

    TrackingData trackingData;

    factory GetTrackOrderData.fromJson(Map<String, dynamic> json) => GetTrackOrderData(
        trackingData: TrackingData.fromJson(json["tracking_data"]),
    );

    Map<String, dynamic> toJson() => {
        "tracking_data": trackingData.toJson(),
    };
}

class TrackingData {
    TrackingData({
        required this.trackUrl,
        required this.awbNo,
        required this.shippingProvider,
    });

    String trackUrl;
    String awbNo;
    String shippingProvider;

    factory TrackingData.fromJson(Map<String, dynamic> json) => TrackingData(
        trackUrl: json["track_url"],
        awbNo: json["awb_no"],
        shippingProvider: json["shipping_provider"],
    );

    Map<String, dynamic> toJson() => {
        "track_url": trackUrl,
        "awb_no": awbNo,
        "shipping_provider": shippingProvider,
    };
}
