import 'dart:convert';

GenerateOrderPayUMoney generateOrderPayUMoneyFromJson(String str) => GenerateOrderPayUMoney.fromJson(json.decode(str));

String generateOrderPayUMoneyToJson(GenerateOrderPayUMoney data) => json.encode(data.toJson());

class GenerateOrderPayUMoney {
    GenerateOrderPayUMoney({
        this.statusCode,
        this.message,
        this.data,
    });

    int ?statusCode;
    String ?message;
    GenerateOrderPayUMoneyData ?data;

    factory GenerateOrderPayUMoney.fromJson(Map<String, dynamic> json) => GenerateOrderPayUMoney(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: GenerateOrderPayUMoneyData.fromJson(json["Data"]),
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": data!.toJson(),
    };
}

class GenerateOrderPayUMoneyData {
    GenerateOrderPayUMoneyData({
        this.upiGateWay,
        this.upiModelList,
        this.dataKey,
        this.amount,
        this.firstname,
        this.productinfo,
        this.txnid,
        this.dataEmail,
        this.phone,
        this.url,
        this.serviceProvider,
        this.surl,
        this.furl,
        this.hash,
        this.mSalt,
        this.key,
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
    dynamic ? dataKey;
    String ?amount;
    String ?firstname;
    String ?productinfo;
    String ?txnid;
    String ?dataEmail;
    String ?phone;
    dynamic ?url;
    String ?serviceProvider;
    String ?surl;
    String ?furl;
    String ?hash;
    dynamic ?mSalt;
    dynamic ?key;
    dynamic ?currency;
    dynamic ?receiptId;
    dynamic ?name;
    dynamic ?description;
    dynamic ?image;
    dynamic ?orderId;
    dynamic ?email;
    dynamic ?mobileNo;
    dynamic ?address;
    dynamic ?theme;
    dynamic ?version;
    dynamic ?signature;
    dynamic ?txnToken;
    dynamic ?mWebsiteName;
    dynamic ?paytmGatewayUrl;
    dynamic ?mid;

    factory GenerateOrderPayUMoneyData.fromJson(Map<String, dynamic> json) => GenerateOrderPayUMoneyData(
        upiGateWay: json["UPIGateWay"],
        upiModelList: List<UpiModelList>.from(json["UPIModelList"].map((x) => UpiModelList.fromJson(x))),
        dataKey: json["key"],
        amount: json["Amount"],
        firstname: json["firstname"],
        productinfo: json["productinfo"],
        txnid: json["txnid"],
        dataEmail: json["email"],
        phone: json["phone"],
        url: json["Url"],
        serviceProvider: json["service_provider"],
        surl: json["surl"],
        furl: json["furl"],
        hash: json["hash"],
        mSalt: json["MSalt"],
        key: json["Key"],
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
        "key": dataKey,
        "Amount": amount,
        "firstname": firstname,
        "productinfo": productinfo,
        "txnid": txnid,
        "email": dataEmail,
        "phone": phone,
        "Url": url,
        "service_provider": serviceProvider,
        "surl": surl,
        "furl": furl,
        "hash": hash,
        "MSalt": mSalt,
        "Key": key,
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
