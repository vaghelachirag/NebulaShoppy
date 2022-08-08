import 'dart:convert';

GetNewProductResponse getNewProductResponseFromJson(String str) => GetNewProductResponse.fromJson(json.decode(str));

String getNewProductResponseToJson(GetNewProductResponse data) => json.encode(data.toJson());

class GetNewProductResponse {
    GetNewProductResponse({
        required this.statusCode,
        required this.message,
        required this.data,
    });

    int statusCode;
    String message;
    List<GetNewProductData> data;

    factory GetNewProductResponse.fromJson(Map<String, dynamic> json) => GetNewProductResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: List<GetNewProductData>.from(json["Data"].map((x) => GetNewProductData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class GetNewProductData {
    GetNewProductData({
        required this.id,
        required this.projectId,
       required this.productId,
       required this.categoryId,
       required this.categoryName,
       required this.name,
       required this.description,
      required  this.mrp,
      required  this.salePrice,
     required   this.saving,
      required  this.quantity,
      required  this.maxSaleQuantity,
     required   this.returnPolicy,
     required   this.warranty,
     required   this.mainImage,
     required   this.inStock,
     required   this.sku,
      required  this.pv,
      required  this.bv,
      required  this.nv,
      required  this.weight,
      required  this.dimension,
     required   this.volWt,
      required  this.displayOrder,
      required  this.shortDescription,
      required  this.homeStorePercent,
       required this.homeStorePrice,
    });

    int id;
    int projectId;
    int productId;
    int categoryId;
    String categoryName;
    String name;
    String description;
    double mrp;
    double salePrice;
    String saving;
    int quantity;
    int maxSaleQuantity;
    String returnPolicy;
    String warranty;
    String mainImage;
    bool inStock;
    String sku;
    String pv;
    String bv;
    String nv;
    String weight;
    String dimension;
    String volWt;
    int displayOrder;
    String shortDescription;
    double homeStorePercent;
    double homeStorePrice;

    factory GetNewProductData.fromJson(Map<String, dynamic> json) => GetNewProductData(
        id: json["Id"],
        projectId: json["ProjectId"],
        productId: json["ProductId"],
        categoryId: json["CategoryId"],
        categoryName: json["CategoryName"],
        name: json["Name"],
        description: json["Description"],
        mrp: json["MRP"],
        salePrice: json["SalePrice"],
        saving: json["Saving"],
        quantity: json["Quantity"],
        maxSaleQuantity: json["MaxSaleQuantity"],
        returnPolicy: json["ReturnPolicy"],
        warranty: json["Warranty"],
        mainImage: json["MainImage"],
        inStock: json["InStock"],
        sku: json["SKU"],
        pv: json["PV"],
        bv:json["BV"],
        nv: json["NV"],
        weight: json["Weight"],
        dimension: json["Dimension"],
        volWt: json["VolWt"],
        displayOrder: json["DisplayOrder"],
        shortDescription: json["ShortDescription"],
        homeStorePercent: json["HomeStorePercent"].toDouble(),
        homeStorePrice: json["HomeStorePrice"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "ProjectId": projectId,
        "ProductId": productId,
        "CategoryId": categoryId,
        "CategoryName": categoryName,
        "Name": name,
        "Description": description,
        "MRP": mrp,
        "SalePrice": salePrice,
        "Saving": saving,
        "Quantity": quantity,
        "MaxSaleQuantity": maxSaleQuantity,
        "ReturnPolicy": returnPolicy,
        "Warranty": warranty,
        "MainImage": mainImage,
        "InStock": inStock,
        "SKU": sku,
        "PV": pv,
        "BV": bv,
        "NV": nv,
        "Weight": weight,
        "Dimension": dimension,
        "VolWt": volWt,
        "DisplayOrder": displayOrder,
        "ShortDescription": shortDescription,
        "HomeStorePercent": homeStorePercent,
        "HomeStorePrice": homeStorePrice,
    };
}


