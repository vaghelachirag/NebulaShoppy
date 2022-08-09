import 'dart:convert';

GetCartlistItem getCartlistItemFromJson(String str) =>
    GetCartlistItem.fromJson(json.decode(str));

String getCartlistItemToJson(GetCartlistItem data) =>
    json.encode(data.toJson());

class GetCartlistItem {
  GetCartlistItem({
    this.statusCode,
    this.message,
    required this.data,
  });

  int? statusCode;
  String? message;
  GetCartItemData data;

  factory GetCartlistItem.fromJson(Map<String, dynamic> json) =>
      GetCartlistItem(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: GetCartItemData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data.toJson(),
      };
}

class GetCartItemData {
  GetCartItemData({
    required this.cart,
    this.shippingCharge,
    this.subTotal,
    this.grandTotal,
    this.totalPv,
    this.totalNv,
    this.totalBv,
    this.retailProfit,
    this.calculatedMrp,
    this.showRetail,
    this.priceSlab,
    this.pvSlab,
    this.showOfferMessage,
    this.mainOfferMessage,
    this.secondaryOfferMessage,
    this.totalItemCount,
    this.ewalletAmount,
    this.subTotalWithEwallet,
    this.shippingWithEwallet,
    this.grandTotalWithEwallet,
    this.isEwalletfreeze,
    this.isEwalletOnOff,
  });

  List<ItemCart> cart;
  int? shippingCharge;
  int? subTotal;
  int? grandTotal;
  int? totalPv;
  int? totalNv;
  int? totalBv;
  int? retailProfit;
  int? calculatedMrp;
  bool? showRetail;
  String? priceSlab;
  String? pvSlab;
  bool? showOfferMessage;
  String? mainOfferMessage;
  String? secondaryOfferMessage;
  int? totalItemCount;
  int? ewalletAmount;
  int? subTotalWithEwallet;
  int? shippingWithEwallet;
  int? grandTotalWithEwallet;
  bool? isEwalletfreeze;
  dynamic? isEwalletOnOff;

  factory GetCartItemData.fromJson(Map<String, dynamic> json) => GetCartItemData(
        cart:
            List<ItemCart>.from(json["Cart"].map((x) => ItemCart.fromJson(x))),
        shippingCharge: json["ShippingCharge"],
        subTotal: json["SubTotal"],
        grandTotal: json["GrandTotal"],
        totalPv: json["TotalPV"],
        totalNv: json["TotalNV"],
        totalBv: json["TotalBV"],
        retailProfit: json["RetailProfit"],
        calculatedMrp: json["CalculatedMRP"],
        showRetail: json["ShowRetail"],
        priceSlab: json["PriceSlab"],
        pvSlab: json["PVSlab"],
        showOfferMessage: json["ShowOfferMessage"],
        mainOfferMessage: json["MainOfferMessage"],
        secondaryOfferMessage: json["SecondaryOfferMessage"],
        totalItemCount: json["TotalItemCount"],
        ewalletAmount: json["EwalletAmount"],
        subTotalWithEwallet: json["SubTotalWithEwallet"],
        shippingWithEwallet: json["ShippingWithEwallet"],
        grandTotalWithEwallet: json["GrandTotalWithEwallet"],
        isEwalletfreeze: json["IsEwalletfreeze"],
        isEwalletOnOff: json["IsEwalletOnOff"],
      );

  Map<String, dynamic> toJson() => {
        "Cart": List<dynamic>.from(cart.map((x) => x.toJson())),
        "ShippingCharge": shippingCharge,
        "SubTotal": subTotal,
        "GrandTotal": grandTotal,
        "TotalPV": totalPv,
        "TotalNV": totalNv,
        "TotalBV": totalBv,
        "RetailProfit": retailProfit,
        "CalculatedMRP": calculatedMrp,
        "ShowRetail": showRetail,
        "PriceSlab": priceSlab,
        "PVSlab": pvSlab,
        "ShowOfferMessage": showOfferMessage,
        "MainOfferMessage": mainOfferMessage,
        "SecondaryOfferMessage": secondaryOfferMessage,
        "TotalItemCount": totalItemCount,
        "EwalletAmount": ewalletAmount,
        "SubTotalWithEwallet": subTotalWithEwallet,
        "ShippingWithEwallet": shippingWithEwallet,
        "GrandTotalWithEwallet": grandTotalWithEwallet,
        "IsEwalletfreeze": isEwalletfreeze,
        "IsEwalletOnOff": isEwalletOnOff,
      };
}

class ItemCart {
  ItemCart({
    required this.id,
    this.deviceId,
    this.userName,
    this.sku,
    this.userId,
    required this.productName,
    this.comboId,
    required this.productId,
    required this.cartQuantity,
    this.stockQuantity,
    this.quantity,
    this.maxSaleQuantity,
    this.inStock,
    this.mrpPrice,
    this.pricePerPiece,
    this.distributorPrice,
    this.saving,
    this.totalPrice,
    required this.mainImage,
    this.dimension,
    this.manufacturer,
    this.volWt,
    this.isComboProduct,
    this.taxRate,
    this.pv,
    this.bv,
    this.nv,
    this.isPromo,
    this.isOnePlusOnePromo,
    required this.isFree,
    this.isRankRewardBronze,
    this.isRankRewardSilver,
    this.isRankRewardGold,
    this.isRankReward,
    this.rankRewardBronzeText,
    this.rankRewardSilverText,
    this.rankRewardGoldText,
    required this.rankRewardText,
    this.variants,
    this.weightInGrams,
    this.weightQty,
    this.isNebProWeight,
  });

  int id;
  String? deviceId;
  String? userName;
  String? sku;
  dynamic? userId;
  String productName;
  int? comboId;
  int productId;
  int cartQuantity;
  int? stockQuantity;
  int? quantity;
  int? maxSaleQuantity;
  bool? inStock;
  int? mrpPrice;
  double? pricePerPiece;
  double? distributorPrice;
  double? saving;
  double? totalPrice;
  String mainImage;
  String? dimension;
  String? manufacturer;
  String? volWt;
  bool? isComboProduct;
  double? taxRate;
  int? pv;
  int? bv;
  int? nv;
  bool? isPromo;
  bool? isOnePlusOnePromo;
  bool isFree;
  bool? isRankRewardBronze;
  bool? isRankRewardSilver;
  bool? isRankRewardGold;
  bool? isRankReward;
  String? rankRewardBronzeText;
  String? rankRewardSilverText;
  String? rankRewardGoldText;
  String rankRewardText;
  int? variants;
  double? weightInGrams;
  double? weightQty;
  bool? isNebProWeight;

  factory ItemCart.fromJson(Map<String, dynamic> json) => ItemCart(
        id: json["Id"],
        deviceId: json["DeviceId"],
        userName: json["UserName"],
        sku: json["SKU"],
        userId: json["UserId"],
        productName: json["ProductName"],
        comboId: json["ComboId"],
        productId: json["ProductId"],
        cartQuantity: json["CartQuantity"],
        stockQuantity: json["StockQuantity"],
        quantity: json["Quantity"],
        maxSaleQuantity: json["MaxSaleQuantity"],
        inStock: json["InStock"],
        mrpPrice: json["MRPPrice"],
        pricePerPiece: json["PricePerPiece"],
        distributorPrice: json["DistributorPrice"],
        saving: json["Saving"],
        totalPrice: json["TotalPrice"],
        mainImage: json["MainImage"],
        dimension: json["Dimension"],
        manufacturer:
            json["Manufacturer"] == null ? null : json["Manufacturer"],
        volWt: json["VolWt"],
        isComboProduct: json["IsComboProduct"],
        taxRate: json["TaxRate"],
        pv: json["PV"],
        bv: json["BV"],
        nv: json["NV"],
        isPromo: json["IsPromo"],
        isOnePlusOnePromo: json["IsOnePlusOnePromo"],
        isFree: json["IsFree"],
        isRankRewardBronze: json["IsRankRewardBronze"],
        isRankRewardSilver: json["IsRankRewardSilver"],
        isRankRewardGold: json["IsRankRewardGold"],
        isRankReward: json["IsRankReward"],
        rankRewardBronzeText: json["RankRewardBronzeText"],
        rankRewardSilverText: json["RankRewardSilverText"],
        rankRewardGoldText: json["RankRewardGoldText"],
        rankRewardText: json["RankRewardText"],
        variants: json["Variants"],
        weightInGrams: json["WeightInGrams"],
        weightQty: json["WeightQty"],
        isNebProWeight: json["IsNebProWeight"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "DeviceId": deviceId,
        "UserName": userName,
        "SKU": sku,
        "UserId": userId,
        "ProductName": productName,
        "ComboId": comboId,
        "ProductId": productId,
        "CartQuantity": cartQuantity,
        "StockQuantity": stockQuantity,
        "Quantity": quantity,
        "MaxSaleQuantity": maxSaleQuantity,
        "InStock": inStock,
        "MRPPrice": mrpPrice,
        "PricePerPiece": pricePerPiece,
        "DistributorPrice": distributorPrice,
        "Saving": saving,
        "TotalPrice": totalPrice,
        "MainImage": mainImage,
        "Dimension": dimension,
        "Manufacturer": manufacturer == null ? null : manufacturer,
        "VolWt": volWt,
        "IsComboProduct": isComboProduct,
        "TaxRate": taxRate,
        "PV": pv,
        "BV": bv,
        "NV": nv,
        "IsPromo": isPromo,
        "IsOnePlusOnePromo": isOnePlusOnePromo,
        "IsFree": isFree,
        "IsRankRewardBronze": isRankRewardBronze,
        "IsRankRewardSilver": isRankRewardSilver,
        "IsRankRewardGold": isRankRewardGold,
        "IsRankReward": isRankReward,
        "RankRewardBronzeText": rankRewardBronzeText,
        "RankRewardSilverText": rankRewardSilverText,
        "RankRewardGoldText": rankRewardGoldText,
        "RankRewardText": rankRewardText,
        "Variants": variants,
        "WeightInGrams": weightInGrams,
        "WeightQty": weightQty,
        "IsNebProWeight": isNebProWeight,
      };
}
