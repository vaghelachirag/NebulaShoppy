import 'dart:convert';

GetCheckProductAvailabiltyResponse getCheckProductAvailabiltyResponseFromJson(String str) => GetCheckProductAvailabiltyResponse.fromJson(json.decode(str));

String getCheckProductAvailabiltyResponseToJson(GetCheckProductAvailabiltyResponse data) => json.encode(data.toJson());

class GetCheckProductAvailabiltyResponse {
    GetCheckProductAvailabiltyResponse({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    int statusCode;
    String message;
    GetCheckProductAvailabiltyData data;

    factory GetCheckProductAvailabiltyResponse.fromJson(Map<String, dynamic> json) => GetCheckProductAvailabiltyResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: GetCheckProductAvailabiltyData.fromJson(json["Data"]),
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data.toJson(),
    };
}

class GetCheckProductAvailabiltyData {
    GetCheckProductAvailabiltyData({
        required this.count,
        required this.outOfStockProducts,
    });

    int count;
    List<OutOfStockProduct> outOfStockProducts;

    factory GetCheckProductAvailabiltyData.fromJson(Map<String, dynamic> json) => GetCheckProductAvailabiltyData(
        count: json["Count"],
        outOfStockProducts: List<OutOfStockProduct>.from(json["OutOfStockProducts"].map((x) => OutOfStockProduct.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Count": count,
        "OutOfStockProducts": List<dynamic>.from(outOfStockProducts.map((x) => x.toJson())),
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
    });

    int id;
    int productId;
    String productName;
    int selectedQuantity;
    String mainImage;
    int availableQty;
    int outOfStockQty;
    String sku;

    factory OutOfStockProduct.fromJson(Map<String, dynamic> json) => OutOfStockProduct(
        id: json["Id"],
        productId: json["ProductId"],
        productName: json["ProductName"],
        selectedQuantity: json["SelectedQuantity"],
        mainImage: json["MainImage"],
        availableQty: json["AvailableQty"],
        outOfStockQty: json["OutOfStockQty"],
        sku: json["SKU"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "ProductId": productId,
        "ProductName": productName,
        "SelectedQuantity": selectedQuantity,
        "MainImage": mainImage,
        "AvailableQty": availableQty,
        "OutOfStockQty": outOfStockQty,
        "SKU": sku,
    };
}
