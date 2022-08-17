import 'dart:convert';

GetOutofStockResponse getOutofStockResponseFromJson(String str) => GetOutofStockResponse.fromJson(json.decode(str));

String getOutofStockResponseToJson(GetOutofStockResponse data) => json.encode(data.toJson());

class GetOutofStockResponse {
    GetOutofStockResponse({
        required this.ok,
        required this.response,
    });

    int ok;
    Response response;

    factory GetOutofStockResponse.fromJson(Map<String, dynamic> json) => GetOutofStockResponse(
        ok: json["ok"],
        response: Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "response": response.toJson(),
    };
}

class Response {
    Response({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    int statusCode;
    String message;
    GetOutofStockData data;

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        statusCode: json["statusCode"],
        message: json["message"],
        data: GetOutofStockData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data.toJson(),
    };
}

class GetOutofStockData {
    GetOutofStockData({
        required this.count,
        required this.outOfStockProducts,
    });

    int count;
    List<OutOfStockProduct> outOfStockProducts;

    factory GetOutofStockData.fromJson(Map<String, dynamic> json) => GetOutofStockData(
        count: json["count"],
        outOfStockProducts: List<OutOfStockProduct>.from(json["outOfStockProducts"].map((x) => OutOfStockProduct.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "outOfStockProducts": List<dynamic>.from(outOfStockProducts.map((x) => x.toJson())),
    };
}

class OutOfStockProduct {
    OutOfStockProduct({
        required this.id,
        required this.productId,
        required this.productName,
        required this.selectedQuantity,
        required this.mainImage,
        required this.availableQty,
        required this.outOfStockQty,
        required this.sku,
        required this.isMandatory,
    });

    int id;
    int productId;
    String productName;
    int selectedQuantity;
    String mainImage;
    int availableQty;
    int outOfStockQty;
    String sku;
    bool isMandatory;

    factory OutOfStockProduct.fromJson(Map<String, dynamic> json) => OutOfStockProduct(
        id: json["id"],
        productId: json["productId"],
        productName: json["productName"],
        selectedQuantity: json["selectedQuantity"],
        mainImage: json["mainImage"],
        availableQty: json["availableQty"],
        outOfStockQty: json["outOfStockQty"],
        sku: json["sku"],
        isMandatory: json["isMandatory"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "productName": productName,
        "selectedQuantity": selectedQuantity,
        "mainImage": mainImage,
        "availableQty": availableQty,
        "outOfStockQty": outOfStockQty,
        "sku": sku,
        "isMandatory": isMandatory,
    };
}
