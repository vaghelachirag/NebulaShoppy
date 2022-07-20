import 'dart:convert';

ItemProductDetail itemProductDetailFromJson(String str) =>
    ItemProductDetail.fromJson(json.decode(str));

String itemProductDetailToJson(ItemProductDetail data) =>
    json.encode(data.toJson());

class ItemProductDetail {
  ItemProductDetail({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  itemProdctDetailData data;

  factory ItemProductDetail.fromJson(Map<String, dynamic> json) =>
      ItemProductDetail(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: itemProdctDetailData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data.toJson(),
      };
}

class itemProdctDetailData {
  itemProdctDetailData({
    required this.id,
    required this.projectId,
    required this.productId,
    required this.categoryId,
    required this.categoryName,
    required this.name,
    required this.description,
    required this.mrp,
    required this.salePrice,
    required this.saving,
    required this.quantity,
    required this.maxSaleQuantity,
    required this.returnPolicy,
    required this.warranty,
    required this.inStock,
    required this.sku,
    required this.weight,
    required this.dimension,
    this.manufacturer,
    required this.pv,
    required this.bv,
    required this.nv,
    required this.shortDescription,
    required this.oneMonthSaleCount,
    required this.showShareLink,
    this.masterProductId,
    required this.isMainProduct,
    this.color,
    this.size,
    this.grossWeight,
    this.brand,
    required this.highlightsIds,
    required this.homeStorePercent,
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
  bool inStock;
  String sku;
  dynamic weight;
  String dimension;
  String? manufacturer;
  double pv;
  String bv;
  double nv;
  String shortDescription;
  int oneMonthSaleCount;
  bool showShareLink;
  dynamic masterProductId;
  bool isMainProduct;
  String? color;
  dynamic size;
  dynamic grossWeight;
  String? brand;
  int highlightsIds;
  double homeStorePercent;
  double homeStorePrice;

  factory itemProdctDetailData.fromJson(Map<String, dynamic> json) =>
      itemProdctDetailData(
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
        inStock: json["InStock"],
        sku: json["SKU"],
        weight: json["Weight"],
        dimension: json["Dimension"],
        manufacturer: json["Manufacturer"],
        pv: json["PV"],
        bv: json["BV"],
        nv: json["NV"],
        shortDescription: json["ShortDescription"],
        oneMonthSaleCount: json["OneMonthSaleCount"],
        showShareLink: json["ShowShareLink"],
        masterProductId: json["MasterProductId"],
        isMainProduct: json["IsMainProduct"],
        color: json["Color"],
        size: json["Size"],
        grossWeight: json["GrossWeight"],
        brand: json["Brand"],
        highlightsIds: json["highlightsIds"],
        homeStorePercent: json["HomeStorePercent"],
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
        "InStock": inStock,
        "SKU": sku,
        "Weight": weight,
        "Dimension": dimension,
        "Manufacturer": manufacturer,
        "PV": pv,
        "BV": bv,
        "NV": nv,
        "ShortDescription": shortDescription,
        "OneMonthSaleCount": oneMonthSaleCount,
        "ShowShareLink": showShareLink,
        "MasterProductId": masterProductId,
        "IsMainProduct": isMainProduct,
        "Color": color,
        "Size": size,
        "GrossWeight": grossWeight,
        "Brand": brand,
        "highlightsIds": highlightsIds,
        "HomeStorePercent": homeStorePercent,
        "HomeStorePrice": homeStorePrice,
      };
}
