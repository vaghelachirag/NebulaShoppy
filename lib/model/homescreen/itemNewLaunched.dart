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
   required this.projectId,
    required this.productId,
    required this.categoryId,
   required this.categoryName,
   required this.pDetailsId,
   required this.cartId,
  required  this.name,
   required this.description,
   required this.sku,
   required this.comboId,
   required this.mrp,
    required this.salePrice,
  required  this.distributorPrice,
  required  this.saving,
   required this.savingString,
   required this.quantity,
   required this.maxSaleQuantity,
   required this.inStock,
   required this.isComboProduct,
   required this.returnPolicy,
  required  this.warranty,
  required  this.mainImage,
  required  this.thumbnailImage,
   required this.weight,
   required this.dimension,
  required  this.manufacturer,
  required  this.volWt,
  required  this.pv,
   required this.pvString,
  required  this.bv,
  required  this.bvString,
  required  this.nv,
  required  this.nvString,
  required  this.displayOrder,
  required  this.shortDescription,
  required  this.taxRate,
   required this.taxAmount,
   required this.total,
   required this.discount,
   required this.productClass,
   required this.isCancellable,
   required this.showShareLink,
   required this.averageRating,
   required this.showInNebPro,
   required this.eComProductDetailsModel,
  });

  int id;
  int projectId;
  int productId;
  int categoryId;
  CategoryName? categoryName;
  int pDetailsId;
  int cartId;
  String name;
  String description;
  String sku;
  int comboId;
  double mrp;
  double salePrice;
  double distributorPrice;
  double saving;
  String savingString;
  int quantity;
  int maxSaleQuantity;
  bool inStock;
  bool isComboProduct;
  String returnPolicy;
  String warranty;
  String mainImage;
  String thumbnailImage;
  String weight;
  String dimension;
  String manufacturer;
  String volWt;
  double pv;
  String pvString;
  double bv;
  String bvString;
  double nv;
  String nvString;
  int displayOrder;
  String shortDescription;
  double taxRate;
  double taxAmount;
  double total;
  double discount;
  dynamic productClass;
  bool isCancellable;
  bool showShareLink;
  double averageRating;
  bool showInNebPro;
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
        savingString: json["SavingString"],
        quantity: json["Quantity"],
        maxSaleQuantity: json["MaxSaleQuantity"],
        inStock: json["InStock"],
        isComboProduct: json["IsComboProduct"],
        returnPolicy: json["ReturnPolicy"],
        warranty: json["Warranty"],
        mainImage: json["MainImage"],
        thumbnailImage: json["ThumbnailImage"],
        weight: json["Weight"],
        dimension: json["Dimension"],
        manufacturer: json["Manufacturer"],
        volWt: json["VolWt"],
        pv: json["PV"],
        pvString: json["PVString"],
        bv: json["BV"],
        bvString:  json["BVString"],
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
        "SavingString": savingString,
        "Quantity": quantity,
        "MaxSaleQuantity": maxSaleQuantity,
        "InStock": inStock,
        "IsComboProduct": isComboProduct,
        "ReturnPolicy":returnPolicy,
        "Warranty": warranty,
        "MainImage": mainImage,
        "ThumbnailImage": thumbnailImage,
        "Weight": weight,
        "Dimension": dimension,
        "Manufacturer": manufacturer,
        "VolWt": volWt,
        "PV": pv,
        "PVString": pvString,
        "BV": bv,
        "BVString": bvString,
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
