import 'dart:convert';

GetGenerateOrderResponse getGenerateOrderResponseFromJson(String str) => GetGenerateOrderResponse.fromJson(json.decode(str));

String getGenerateOrderResponseToJson(GetGenerateOrderResponse data) => json.encode(data.toJson());

class GetGenerateOrderResponse {
    GetGenerateOrderResponse({
        this.statusCode,
        this.message,
        this.data,
    });

    int ?statusCode;
    String ?message;
    GetGenerateOrderData ?data;

    factory GetGenerateOrderResponse.fromJson(Map<String, dynamic> json) => GetGenerateOrderResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: GetGenerateOrderData.fromJson(json["Data"]),
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data!.toJson(),
    };
}

class GetGenerateOrderData {
    GetGenerateOrderData({
        this.upiGateWay,
        this.upiModelList,
        this.key,
        this.amount,
        this.currency,
        this.receiptId,
        this.name,
        this.description,
        this.image,
        this.orderId,
        this.email,
        this.mobileNo,
        this.address,
        this.theme,
        this.version,
        this.signature,
        this.txnToken,
        this.mWebsiteName,
        this.paytmGatewayUrl,
        this.mid,
    });

    String ?upiGateWay;
    List<UpiModelList> ?upiModelList;
    String ?key;
    String ?amount;
    String ?currency;
    String ?receiptId;
    String ?name;
    String ?description;
    String ?image;
    String ?orderId;
    String ?email;
    String ?mobileNo;
    String ?address;
    String ?theme;
    dynamic ?version;
    String ?signature;
    String ?txnToken;
    String ?mWebsiteName;
    String ?paytmGatewayUrl;
    String ?mid;

    factory GetGenerateOrderData.fromJson(Map<String, dynamic> json) => GetGenerateOrderData(
        upiGateWay: json["UPIGateWay"],
        upiModelList: List<UpiModelList>.from(json["UPIModelList"].map((x) => UpiModelList.fromJson(x))),
        key: json["Key"],
        amount: json["Amount"],
        currency: json["Currency"],
        receiptId: json["ReceiptId"],
        name: json["Name"],
        description: json["Description"],
        image: json["Image"],
        orderId: json["OrderId"],
        email: json["Email"],
        mobileNo: json["MobileNo"],
        address: json["Address"],
        theme: json["Theme"],
        version: json["Version"],
        signature: json["Signature"],
        txnToken: json["txnToken"],
        mWebsiteName: json["MWebsiteName"],
        paytmGatewayUrl: json["PaytmGatewayURL"],
        mid: json["MID"],
    );

    Map<String, dynamic> toJson() => {
        "UPIGateWay": upiGateWay,
        "UPIModelList": List<dynamic>.from(upiModelList!.map((x) => x.toJson())),
        "Key": key,
        "Amount": amount,
        "Currency": currency,
        "ReceiptId": receiptId,
        "Name": name,
        "Description": description,
        "Image": image,
        "OrderId": orderId,
        "Email": email,
        "MobileNo": mobileNo,
        "Address": address,
        "Theme": theme,
        "Version": version,
        "Signature": signature,
        "txnToken": txnToken,
        "MWebsiteName": mWebsiteName,
        "PaytmGatewayURL": paytmGatewayUrl,
        "MID": mid,
    };
}

class UpiModelList {
    UpiModelList({
        this.packageType,
        this.packageName,
        this.imageFile,
    });

    String ?packageType;
    String ?packageName;
    String ?imageFile;

    factory UpiModelList.fromJson(Map<String, dynamic> json) => UpiModelList(
        packageType: json["PackageType"],
        packageName: json["PackageName"],
        imageFile: json["ImageFile"],
    );

    Map<String, dynamic> toJson() => {
        "PackageType": packageType,
        "PackageName": packageName,
        "ImageFile": imageFile,
    };
}
