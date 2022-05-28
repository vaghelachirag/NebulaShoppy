import 'dart:convert';

ItemProductVariant itemProductVariantFromJson(String str) =>
    ItemProductVariant.fromJson(json.decode(str));

String itemProductVariantToJson(ItemProductVariant data) =>
    json.encode(data.toJson());

class ItemProductVariant {
  ItemProductVariant({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  List<ItemProductVariantData>? data;

  factory ItemProductVariant.fromJson(Map<String, dynamic> json) =>
      ItemProductVariant(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: List<ItemProductVariantData>.from(
            json["Data"].map((x) => ItemProductVariantData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ItemProductVariantData {
  ItemProductVariantData({
    required this.mainKey,
    required this.ecomAttributeValueList,
  });

  String mainKey;
  List<EcomAttributeValueList> ecomAttributeValueList;

  factory ItemProductVariantData.fromJson(Map<String, dynamic> json) =>
      ItemProductVariantData(
        mainKey: json["MainKey"],
        ecomAttributeValueList: List<EcomAttributeValueList>.from(
            json["EcomAttributeValueList"]
                .map((x) => EcomAttributeValueList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "MainKey": mainKey,
        "EcomAttributeValueList":
            List<dynamic>.from(ecomAttributeValueList.map((x) => x.toJson())),
      };
}

class EcomAttributeValueList {
  EcomAttributeValueList({
    this.attributeName,
    this.attributeColor,
    this.ecomAttributeSkuList,
  });

  String? attributeName;
  String? attributeColor;
  List<int>? ecomAttributeSkuList;

  factory EcomAttributeValueList.fromJson(Map<String, dynamic> json) =>
      EcomAttributeValueList(
        attributeName: json["AttributeName"],
        attributeColor: json["AttributeColor"],
        ecomAttributeSkuList:
            List<int>.from(json["EcomAttributeSKUList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "AttributeName": attributeName,
        "AttributeColor": attributeColor,
        "EcomAttributeSKUList":
            List<dynamic>.from(ecomAttributeSkuList!.map((x) => x)),
      };
}
