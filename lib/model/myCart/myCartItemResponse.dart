class getmycartItemResponse {
 late int statusCode;
 late String message;
 late  getmycartItemData data;

  getmycartItemResponse({required this.statusCode, required this.message, required this.data});

  getmycartItemResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'];
    data = (json['Data'] != null ? new getmycartItemData.fromJson(json['Data']) : null) as getmycartItemData;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusCode'] = this.statusCode;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class getmycartItemData{
 late List<Cart> cart;
late  int shippingCharge;
 late int subTotal;
late  int grandTotal;
 late  int totalPV;
late  int totalNV;
 late  int totalBV;
late  int retailProfit;
 late int calculatedMRP;
late   bool showRetail;
late  String priceSlab;
 late String pVSlab;
 late  bool showOfferMessage;
 late String mainOfferMessage;
 late String secondaryOfferMessage;
 late int totalItemCount;
late   int ewalletAmount;
 late  int subTotalWithEwallet;
late  int shippingWithEwallet;
 late int grandTotalWithEwallet;
 late bool isEwalletfreeze;
 late String isEwalletOnOff;

  getmycartItemData(
      {required this.cart,
      required this.shippingCharge,
      required this.subTotal,
      required this.grandTotal,
      required this.totalPV,
      required this.totalNV,
      required this.totalBV,
      required this.retailProfit,
      required this.calculatedMRP,
      required this.showRetail,
      required this.priceSlab,
      required this.pVSlab,
      required this.showOfferMessage,
      required this.mainOfferMessage,
      required this.secondaryOfferMessage,
      required this.totalItemCount,
      required this.ewalletAmount,
      required this.subTotalWithEwallet,
      required this.shippingWithEwallet,
      required this.grandTotalWithEwallet,
      required this.isEwalletfreeze,
      required this.isEwalletOnOff});

  getmycartItemData.fromJson(Map<String, dynamic> json) {
    if (json['Cart'] != null) {
      // ignore: deprecated_member_use
      cart = <Cart>[];
      json['Cart'].forEach((v) {
        cart.add(new Cart.fromJson(v));
      });
    }
    shippingCharge = json['ShippingCharge'];
    subTotal = json['SubTotal'];
    grandTotal = json['GrandTotal'];
    totalPV = json['TotalPV'];
    totalNV = json['TotalNV'];
    totalBV = json['TotalBV'];
    retailProfit = json['RetailProfit'];
    calculatedMRP = json['CalculatedMRP'];
    showRetail = json['ShowRetail'];
    priceSlab = json['PriceSlab'];
    pVSlab = json['PVSlab'];
    showOfferMessage = json['ShowOfferMessage'];
    mainOfferMessage = json['MainOfferMessage'];
    secondaryOfferMessage = json['SecondaryOfferMessage'];
    totalItemCount = json['TotalItemCount'];
    ewalletAmount = json['EwalletAmount'];
    subTotalWithEwallet = json['SubTotalWithEwallet'];
    shippingWithEwallet = json['ShippingWithEwallet'];
    grandTotalWithEwallet = json['GrandTotalWithEwallet'];
    isEwalletfreeze = json['IsEwalletfreeze'];
    isEwalletOnOff = json['IsEwalletOnOff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['Cart'] = this.cart.map((v) => v.toJson()).toList();
    }
    data['ShippingCharge'] = this.shippingCharge;
    data['SubTotal'] = this.subTotal;
    data['GrandTotal'] = this.grandTotal;
    data['TotalPV'] = this.totalPV;
    data['TotalNV'] = this.totalNV;
    data['TotalBV'] = this.totalBV;
    data['RetailProfit'] = this.retailProfit;
    data['CalculatedMRP'] = this.calculatedMRP;
    data['ShowRetail'] = this.showRetail;
    data['PriceSlab'] = this.priceSlab;
    data['PVSlab'] = this.pVSlab;
    data['ShowOfferMessage'] = this.showOfferMessage;
    data['MainOfferMessage'] = this.mainOfferMessage;
    data['SecondaryOfferMessage'] = this.secondaryOfferMessage;
    data['TotalItemCount'] = this.totalItemCount;
    data['EwalletAmount'] = this.ewalletAmount;
    data['SubTotalWithEwallet'] = this.subTotalWithEwallet;
    data['ShippingWithEwallet'] = this.shippingWithEwallet;
    data['GrandTotalWithEwallet'] = this.grandTotalWithEwallet;
    data['IsEwalletfreeze'] = this.isEwalletfreeze;
    data['IsEwalletOnOff'] = this.isEwalletOnOff;
    return data;
  }
}

class Cart {
 late int id;
late  String deviceId;
 late String userName;
 late String sKU;
 late String userId;
 late String productName;
 late int comboId;
 late int productId;
 late int cartQuantity;
 late int stockQuantity;
 late int quantity;
 late int maxSaleQuantity;
 late bool inStock;
late  int mRPPrice;
 late int pricePerPiece;
late  int distributorPrice;
 late int saving;
late  int totalPrice;
late  String mainImage;
late  String dimension;
 late String manufacturer;
 late String volWt;
 late bool isComboProduct;
 late int taxRate;
 late int pV;
 late int bV;
 late int nV;
 late bool isPromo;
 late bool isOnePlusOnePromo;
 late bool isFree;
  late bool isRankRewardBronze;
late  bool isRankRewardSilver;
late  bool isRankRewardGold;
late  bool isRankReward;
late  String rankRewardBronzeText;
late  String rankRewardSilverText;
late  String rankRewardGoldText;
late  String rankRewardText;
late  int variants;
late  int weightInGrams;
late  int weightQty;
late  bool isNebProWeight;

  Cart(
      {required this.id,
    required  this.deviceId,
    required  this.userName,
    required  this.sKU,
     required this.userId,
     required this.productName,
     required this.comboId,
     required this.productId,
     required this.cartQuantity,
    required  this.stockQuantity,
   required   this.quantity,
     required this.maxSaleQuantity,
     required this.inStock,
     required this.mRPPrice,
     required this.pricePerPiece,
     required this.distributorPrice,
    required  this.saving,
   required  this.totalPrice,
   required   this.mainImage,
      required this.dimension,
    required  this.manufacturer,
    required  this.volWt,
    required  this.isComboProduct,
    required  this.taxRate,
   required   this.pV,
    required  this.bV,
    required  this.nV,
   required   this.isPromo,
   required   this.isOnePlusOnePromo,
   required   this.isFree,
   required   this.isRankRewardBronze,
    required  this.isRankRewardSilver,
   required   this.isRankRewardGold,
    required  this.isRankReward,
     required this.rankRewardBronzeText,
     required this.rankRewardSilverText,
    required  this.rankRewardGoldText,
     required this.rankRewardText,
   required   this.variants,
    required  this.weightInGrams,
    required  this.weightQty,
    required  this.isNebProWeight});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    deviceId = json['DeviceId'];
    userName = json['UserName'];
    sKU = json['SKU'];
    userId = json['UserId'];
    productName = json['ProductName'];
    comboId = json['ComboId'];
    productId = json['ProductId'];
    cartQuantity = json['CartQuantity'];
    stockQuantity = json['StockQuantity'];
    quantity = json['Quantity'];
    maxSaleQuantity = json['MaxSaleQuantity'];
    inStock = json['InStock'];
    mRPPrice = json['MRPPrice'];
    pricePerPiece = json['PricePerPiece'];
    distributorPrice = json['DistributorPrice'];
    saving = json['Saving'];
    totalPrice = json['TotalPrice'];
    mainImage = json['MainImage'];
    dimension = json['Dimension'];
    manufacturer = json['Manufacturer'];
    volWt = json['VolWt'];
    isComboProduct = json['IsComboProduct'];
    taxRate = json['TaxRate'];
    pV = json['PV'];
    bV = json['BV'];
    nV = json['NV'];
    isPromo = json['IsPromo'];
    isOnePlusOnePromo = json['IsOnePlusOnePromo'];
    isFree = json['IsFree'];
    isRankRewardBronze = json['IsRankRewardBronze'];
    isRankRewardSilver = json['IsRankRewardSilver'];
    isRankRewardGold = json['IsRankRewardGold'];
    isRankReward = json['IsRankReward'];
    rankRewardBronzeText = json['RankRewardBronzeText'];
    rankRewardSilverText = json['RankRewardSilverText'];
    rankRewardGoldText = json['RankRewardGoldText'];
    rankRewardText = json['RankRewardText'];
    variants = json['Variants'];
    weightInGrams = json['WeightInGrams'];
    weightQty = json['WeightQty'];
    isNebProWeight = json['IsNebProWeight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['DeviceId'] = this.deviceId;
    data['UserName'] = this.userName;
    data['SKU'] = this.sKU;
    data['UserId'] = this.userId;
    data['ProductName'] = this.productName;
    data['ComboId'] = this.comboId;
    data['ProductId'] = this.productId;
    data['CartQuantity'] = this.cartQuantity;
    data['StockQuantity'] = this.stockQuantity;
    data['Quantity'] = this.quantity;
    data['MaxSaleQuantity'] = this.maxSaleQuantity;
    data['InStock'] = this.inStock;
    data['MRPPrice'] = this.mRPPrice;
    data['PricePerPiece'] = this.pricePerPiece;
    data['DistributorPrice'] = this.distributorPrice;
    data['Saving'] = this.saving;
    data['TotalPrice'] = this.totalPrice;
    data['MainImage'] = this.mainImage;
    data['Dimension'] = this.dimension;
    data['Manufacturer'] = this.manufacturer;
    data['VolWt'] = this.volWt;
    data['IsComboProduct'] = this.isComboProduct;
    data['TaxRate'] = this.taxRate;
    data['PV'] = this.pV;
    data['BV'] = this.bV;
    data['NV'] = this.nV;
    data['IsPromo'] = this.isPromo;
    data['IsOnePlusOnePromo'] = this.isOnePlusOnePromo;
    data['IsFree'] = this.isFree;
    data['IsRankRewardBronze'] = this.isRankRewardBronze;
    data['IsRankRewardSilver'] = this.isRankRewardSilver;
    data['IsRankRewardGold'] = this.isRankRewardGold;
    data['IsRankReward'] = this.isRankReward;
    data['RankRewardBronzeText'] = this.rankRewardBronzeText;
    data['RankRewardSilverText'] = this.rankRewardSilverText;
    data['RankRewardGoldText'] = this.rankRewardGoldText;
    data['RankRewardText'] = this.rankRewardText;
    data['Variants'] = this.variants;
    data['WeightInGrams'] = this.weightInGrams;
    data['WeightQty'] = this.weightQty;
    data['IsNebProWeight'] = this.isNebProWeight;
    return data;
  }
}
