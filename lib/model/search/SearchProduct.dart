import 'dart:convert';

SearchProduct searchProductFromJson(String str) =>
    SearchProduct.fromJson(json.decode(str));

String searchProductToJson(SearchProduct data) => json.encode(data.toJson());

class SearchProduct {
  SearchProduct({
    this.statusCode,
    this.message,
    required this.data,
  });

  int? statusCode;
  String? message;
  List<SearchData> data;

  factory SearchProduct.fromJson(Map<String, dynamic> json) => SearchProduct(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: List<SearchData>.from(
            json["Data"].map((x) => SearchData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SearchData {
  SearchData({
    required this.id,
    this.projectId,
    required this.productId,
    required this.categoryId,
    this.name,
    this.description,
    this.mrp,
    this.salePrice,
    this.saving,
    this.quantity,
    this.maxSaleQuantity,
    this.mainImage,
    this.inStock,
    this.sku,
    this.weight,
    this.dimension,
    this.manufacturer,
    this.volWt,
    this.homeStorePercent,
    this.homeStorePrice,
  });

  int id;
  int? projectId;
  int productId;
  int categoryId;
  String? name;
  String? description;
  double? mrp;
  double? salePrice;
  String? saving;
  int? quantity;
  int? maxSaleQuantity;
  String? mainImage;
  bool? inStock;
  String? sku;
  String? weight;
  String? dimension;
  String? manufacturer;
  String? volWt;
  double? homeStorePercent;
  double? homeStorePrice;

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
        id: json["Id"],
        projectId: json["ProjectId"],
        productId: json["ProductId"],
        categoryId: json["CategoryId"],
        name: json["Name"],
        description: json["Description"],
        mrp: json["MRP"],
        salePrice: json["SalePrice"],
        saving: json["Saving"],
        quantity: json["Quantity"],
        maxSaleQuantity: json["MaxSaleQuantity"],
        mainImage: json["MainImage"],
        inStock: json["InStock"],
        sku: json["SKU"],
        weight: json["Weight"] == null ? null : json["Weight"],
        dimension: json["Dimension"],
        manufacturer:
            json["Manufacturer"] == null ? null : json["Manufacturer"],
        volWt: json["VolWt"] == null ? null : json["VolWt"],
        homeStorePercent: json["HomeStorePercent"].toDouble(),
        homeStorePrice: json["HomeStorePrice"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ProjectId": projectId,
        "ProductId": productId,
        "CategoryId": categoryId,
        "Name": name,
        "Description": description,
        "MRP": mrp,
        "SalePrice": salePrice,
        "Saving": saving,
        "Quantity": quantity,
        "MaxSaleQuantity": maxSaleQuantity,
        "MainImage": mainImage,
        "InStock": inStock,
        "SKU": sku,
        "Weight": weight == null ? null : weight,
        "Dimension": dimension,
        "Manufacturer": manufacturer == null ? null : manufacturer,
        "VolWt": volWt == null ? null : volWt,
        "HomeStorePercent": homeStorePercent,
        "HomeStorePrice": homeStorePrice,
      };
}
