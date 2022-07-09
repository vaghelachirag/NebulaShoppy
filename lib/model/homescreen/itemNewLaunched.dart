import 'dart:convert';

ItemNewLaunched itemNewLaunchedFromJson(String str) =>
    ItemNewLaunched.fromJson(json.decode(str));

String itemNewLaunchedToJson(ItemNewLaunched data) =>
    json.encode(data.toJson());

class ItemNewLaunched {
  ItemNewLaunched({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  Data data;

  factory ItemNewLaunched.fromJson(Map<String, dynamic> json) =>
      ItemNewLaunched(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data.toJson(),
      };
}

class Data {
  Data({
    required this.totalRecord,
    required this.products,
  });

  int totalRecord;
  List<itemNewLaunchedProduct> products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalRecord: json["TotalRecord"],
        products: List<itemNewLaunchedProduct>.from(
            json["Products"].map((x) => itemNewLaunchedProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TotalRecord": totalRecord,
        "Products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class itemNewLaunchedProduct {
  itemNewLaunchedProduct({
    required this.id,
    this.projectId,
    required this.productId,
    required this.categoryId,
    this.categoryName,
    this.pDetailsId,
    this.cartId,
    this.name,
    this.description,
    this.sku,
    this.comboId,
    this.mrp,
    required this.salePrice,
    this.distributorPrice,
    this.saving,
    this.savingString,
    this.quantity,
    this.maxSaleQuantity,
    this.inStock,
    this.isComboProduct,
    this.returnPolicy,
    this.warranty,
    this.mainImage,
    this.thumbnailImage,
    this.weight,
    this.dimension,
    this.manufacturer,
    this.volWt,
    this.pv,
    this.pvString,
    this.bv,
    this.bvString,
    this.nv,
    this.nvString,
    this.displayOrder,
    this.shortDescription,
    this.taxRate,
    this.taxAmount,
    this.total,
    this.discount,
    this.productClass,
    this.isCancellable,
    this.showShareLink,
    this.averageRating,
    this.showInNebPro,
    this.eComProductDetailsModel,
  });

  int id;
  int? projectId;
  int productId;
  int categoryId;
  CategoryName? categoryName;
  int? pDetailsId;
  int? cartId;
  String? name;
  String? description;
  String? sku;
  int? comboId;
  double? mrp;
  double salePrice;
  double? distributorPrice;
  double? saving;
  SavingString? savingString;
  int? quantity;
  int? maxSaleQuantity;
  bool? inStock;
  bool? isComboProduct;
  ReturnPolicy? returnPolicy;
  Warranty? warranty;
  String? mainImage;
  String? thumbnailImage;
  VolWt? weight;
  Dimension? dimension;
  Manufacturer? manufacturer;
  VolWt? volWt;
  double? pv;
  String? pvString;
  double? bv;
  BvString? bvString;
  double? nv;
  String? nvString;
  int? displayOrder;
  String? shortDescription;
  double? taxRate;
  double? taxAmount;
  double? total;
  double? discount;
  dynamic? productClass;
  bool? isCancellable;
  bool? showShareLink;
  double? averageRating;
  bool? showInNebPro;
  dynamic? eComProductDetailsModel;

  factory itemNewLaunchedProduct.fromJson(Map<String, dynamic> json) =>
      itemNewLaunchedProduct(
        id: json["Id"],
        projectId: json["ProjectId"],
        productId: json["ProductId"],
        categoryId: json["CategoryId"],
        categoryName: categoryNameValues.map[json["CategoryName"]],
        pDetailsId: json["PDetailsId"],
        cartId: json["CartId"],
        name: json["Name"],
        description: json["Description"],
        sku: json["SKU"],
        comboId: json["ComboID"],
        mrp: json["MRP"],
        salePrice: json["SalePrice"],
        distributorPrice: json["DistributorPrice"],
        saving: json["Saving"],
        savingString: savingStringValues.map[json["SavingString"]],
        quantity: json["Quantity"],
        maxSaleQuantity: json["MaxSaleQuantity"],
        inStock: json["InStock"],
        isComboProduct: json["IsComboProduct"],
        returnPolicy: returnPolicyValues.map[json["ReturnPolicy"]],
        warranty: warrantyValues.map[json["Warranty"]],
        mainImage: json["MainImage"],
        thumbnailImage: json["ThumbnailImage"],
        weight: volWtValues.map[json["Weight"]],
        dimension: dimensionValues.map[json["Dimension"]],
        manufacturer: manufacturerValues.map[json["Manufacturer"]],
        volWt: volWtValues.map[json["VolWt"]],
        pv: json["PV"],
        pvString: json["PVString"],
        bv: json["BV"],
        bvString: bvStringValues.map[json["BVString"]],
        nv: json["NV"],
        nvString: json["NVString"],
        displayOrder: json["DisplayOrder"],
        shortDescription: json["ShortDescription"],
        taxRate: json["TaxRate"],
        taxAmount: json["TaxAmount"],
        total: json["Total"],
        discount: json["Discount"],
        productClass: json["Class"],
        isCancellable: json["IsCancellable"],
        showShareLink: json["ShowShareLink"],
        averageRating: json["AverageRating"],
        showInNebPro: json["ShowInNebPro"],
        eComProductDetailsModel: json["EComProductDetailsModel"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ProjectId": projectId,
        "ProductId": productId,
        "CategoryId": categoryId,
        "CategoryName": categoryNameValues.reverse[categoryName],
        "PDetailsId": pDetailsId,
        "CartId": cartId,
        "Name": name,
        "Description": description,
        "SKU": sku,
        "ComboID": comboId,
        "MRP": mrp,
        "SalePrice": salePrice,
        "DistributorPrice": distributorPrice,
        "Saving": saving,
        "SavingString": savingStringValues.reverse[savingString],
        "Quantity": quantity,
        "MaxSaleQuantity": maxSaleQuantity,
        "InStock": inStock,
        "IsComboProduct": isComboProduct,
        "ReturnPolicy": returnPolicyValues.reverse[returnPolicy],
        "Warranty": warrantyValues.reverse[warranty],
        "MainImage": mainImage,
        "ThumbnailImage": thumbnailImage,
        "Weight": volWtValues.reverse[weight],
        "Dimension": dimensionValues.reverse[dimension],
        "Manufacturer": manufacturerValues.reverse[manufacturer],
        "VolWt": volWtValues.reverse[volWt],
        "PV": pv,
        "PVString": pvString,
        "BV": bv,
        "BVString": bvStringValues.reverse[bvString],
        "NV": nv,
        "NVString": nvString,
        "DisplayOrder": displayOrder,
        "ShortDescription": shortDescription,
        "TaxRate": taxRate,
        "TaxAmount": taxAmount,
        "Total": total,
        "Discount": discount,
        "Class": productClass,
        "IsCancellable": isCancellable,
        "ShowShareLink": showShareLink,
        "AverageRating": averageRating,
        "ShowInNebPro": showInNebPro,
        "EComProductDetailsModel": eComProductDetailsModel,
      };
}

enum BvString { THE_6 }

final bvStringValues = EnumValues({"6%": BvString.THE_6});

enum CategoryName { STORAGE }

final categoryNameValues = EnumValues({"Storage": CategoryName.STORAGE});

enum Dimension { XX, THE_235_MMX175_MMX145_MM }

final dimensionValues = EnumValues({
  "235 mmx175 mmx145 mm": Dimension.THE_235_MMX175_MMX145_MM,
  "xx": Dimension.XX
});

enum Manufacturer { EMPTY, SPL_PLAST_PVT_LTD }

final manufacturerValues = EnumValues({
  "": Manufacturer.EMPTY,
  "SPL Plast Pvt. Ltd.": Manufacturer.SPL_PLAST_PVT_LTD
});

enum ReturnPolicy { THE_0_DAYS_RETURNABLE }

final returnPolicyValues =
    EnumValues({"0 Days Returnable": ReturnPolicy.THE_0_DAYS_RETURNABLE});

enum SavingString { SAVINGS_OF_40, SAVINGS_OF_30 }

final savingStringValues = EnumValues({
  "Savings of 30%": SavingString.SAVINGS_OF_30,
  "Savings of 40%": SavingString.SAVINGS_OF_40
});

enum VolWt { TOTAL_1_L_X_44_L, THE_1_L, TOTAL_124_L }

final volWtValues = EnumValues({
  "1L": VolWt.THE_1_L,
  "Total: 12.4L": VolWt.TOTAL_124_L,
  "Total: 1L x 4 = 4L": VolWt.TOTAL_1_L_X_44_L
});

enum Warranty { THE_1_YEARS_WARRANTY }

final warrantyValues =
    EnumValues({"1 Years Warranty": Warranty.THE_1_YEARS_WARRANTY});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
