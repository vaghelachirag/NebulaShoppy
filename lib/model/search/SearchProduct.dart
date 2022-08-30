class getSearchDataResonse {
  int? statusCode;
  String? message;
  List<SearchData>? data;

  getSearchDataResonse({this.statusCode, this.message, this.data});

  getSearchDataResonse.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['Data'] != null) {
      data = <SearchData>[];
      json['Data'].forEach((v) {
        data!.add(new SearchData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusCode'] = this.statusCode;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchData {
 late int id;
 late int? projectId;
 late int productId;
 late  int categoryId;
  String? name;
  String? description;
  double? mRP;
  double? salePrice;
  String? saving;
  int? quantity;
  int? maxSaleQuantity;
  String? returnPolicy;
  String? warranty;
  String? mainImage;
  bool? inStock;
  String? sKU;
  String? weight;
  String? dimension;
  String? manufacturer;
  String? volWt;
  double? homeStorePercent;
  double? homeStorePrice;

  SearchData(
      {required this.id,
      this.projectId,
      required this.productId,
      required this.categoryId,
      this.name,
      this.description,
      this.mRP,
      this.salePrice,
      this.saving,
      this.quantity,
      this.maxSaleQuantity,
      this.returnPolicy,
      this.warranty,
      this.mainImage,
      this.inStock,
      this.sKU,
      this.weight,
      this.dimension,
      this.manufacturer,
      this.volWt,
      this.homeStorePercent,
      this.homeStorePrice});

  SearchData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    projectId = json['ProjectId'];
    productId = json['ProductId'];
    categoryId = json['CategoryId'];
    name = json['Name'];
    description = json['Description'];
    mRP = json['MRP'];
    salePrice = json['SalePrice'];
    saving = json['Saving'];
    quantity = json['Quantity'];
    maxSaleQuantity = json['MaxSaleQuantity'];
    returnPolicy = json['ReturnPolicy'];
    warranty = json['Warranty'];
    mainImage = json['MainImage'];
    inStock = json['InStock'];
    sKU = json['SKU'];
    weight = json['Weight'];
    dimension = json['Dimension'];
    manufacturer = json['Manufacturer'];
    volWt = json['VolWt'];
    homeStorePercent = json['HomeStorePercent'];
    homeStorePrice = json['HomeStorePrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ProjectId'] = this.projectId;
    data['ProductId'] = this.productId;
    data['CategoryId'] = this.categoryId;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['MRP'] = this.mRP;
    data['SalePrice'] = this.salePrice;
    data['Saving'] = this.saving;
    data['Quantity'] = this.quantity;
    data['MaxSaleQuantity'] = this.maxSaleQuantity;
    data['ReturnPolicy'] = this.returnPolicy;
    data['Warranty'] = this.warranty;
    data['MainImage'] = this.mainImage;
    data['InStock'] = this.inStock;
    data['SKU'] = this.sKU;
    data['Weight'] = this.weight;
    data['Dimension'] = this.dimension;
    data['Manufacturer'] = this.manufacturer;
    data['VolWt'] = this.volWt;
    data['HomeStorePercent'] = this.homeStorePercent;
    data['HomeStorePrice'] = this.homeStorePrice;
    return data;
  }
}