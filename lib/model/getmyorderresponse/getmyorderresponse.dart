import 'dart:convert';

GetMyOrderResponse getMyOrderResponseFromJson(String str) => GetMyOrderResponse.fromJson(json.decode(str));

String getMyOrderResponseToJson(GetMyOrderResponse data) => json.encode(data.toJson());

class GetMyOrderResponse {
    GetMyOrderResponse({
        this.statusCode,
        this.message,
        required this.data,
    });

    int ?statusCode;
    Message ?message;
    List<GetMyOrderData> data;

    factory GetMyOrderResponse.fromJson(Map<String, dynamic> json) => GetMyOrderResponse(
        statusCode: json["StatusCode"],
        message: messageValues.map[json["Message"]],
        data: List<GetMyOrderData>.from(json["Data"].map((x) => GetMyOrderData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": messageValues.reverse[message],
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class GetMyOrderData {
    GetMyOrderData({
        this.masterId,
        this.orderNumber,
        this.userId,
        this.userName,
        this.mobileNo,
        this.paymentModeId,
        this.paymentMode,
        required this.orderDate,
        this.shippingDate,
        this.requiredDate,
        this.shipperId,
        this.shipper,
        this.freight,
        this.subTotal,
        this.shippingCharges,
        this.grandTotal,
        this.itemOrderedCount,
        this.timeStamp,
        this.transactionId,
        this.transactionStatus,
        this.fulfilled,
        this.paymentDate,
        this.billingAddressId,
        this.billingAddressUser,
        this.billingAddresses,
        this.shippingAddressId,
        this.shippingAddressUser,
        this.shippingAddresses,
        this.isPickUpPoint,
        this.createdOn,
        this.updatedOn,
        this.isDelete,
        this.isFullOrderDelivered,
        this.imageUrl,
        this.status,
        required this.statusUpdatedOn,
        this.eWalletAmount,
        this.orderDetails,
    });

    int ?masterId;
    String ?orderNumber;
    String ?userId;
    BillingAddressUser ?userName;
    String ?mobileNo;
    int ?paymentModeId;
    PaymentMode ?paymentMode;
    int orderDate;
    dynamic ?shippingDate;
    dynamic ?requiredDate;
    int ?shipperId;
    Shipper ?shipper;
    double ?freight;
    double ?subTotal;
    double ?shippingCharges;
    double ?grandTotal;
    int ?itemOrderedCount;
    String ?timeStamp;
    String ?transactionId;
    Message ?transactionStatus;
    bool ?fulfilled;
    dynamic ?paymentDate;
    int ?billingAddressId;
    BillingAddressUser ?billingAddressUser;
    String ?billingAddresses;
    int ?shippingAddressId;
    BillingAddressUser ?shippingAddressUser;
    String ?shippingAddresses;
    int ?isPickUpPoint;
    dynamic ?createdOn;
    dynamic ?updatedOn;
    bool ?isDelete;
    bool ?isFullOrderDelivered;
    String ?imageUrl;
    DatumStatus ?status;
    String statusUpdatedOn;
    double ?eWalletAmount;
    List<OrderDetail> ?orderDetails;

    factory GetMyOrderData.fromJson(Map<String, dynamic> json) => GetMyOrderData(
        masterId: json["MasterId"],
        orderNumber: json["OrderNumber"],
        userId: json["UserId"],
        userName: billingAddressUserValues.map[json["UserName"]],
        mobileNo: json["MobileNo"],
        paymentModeId: json["PaymentModeId"],
        paymentMode: paymentModeValues.map[json["PaymentMode"]],
        orderDate: json["OrderDate"],
        shippingDate: json["ShippingDate"],
        requiredDate:  json["RequiredDate"],
        shipperId: json["ShipperId"],
        shipper: shipperValues.map[json["Shipper"]],
        freight: json["Freight"],
        subTotal: json["SubTotal"],
        shippingCharges: json["ShippingCharges"],
        grandTotal: json["GrandTotal"],
        itemOrderedCount: json["itemOrderedCount"],
        timeStamp: json["TimeStamp"],
        transactionId: json["TransactionId"],
        transactionStatus: messageValues.map[json["TransactionStatus"]],
        fulfilled: json["Fulfilled"],
        paymentDate: json["PaymentDate"],
        billingAddressId: json["BillingAddressId"],
        billingAddressUser: billingAddressUserValues.map[json["BillingAddressUser"]],
        billingAddresses: json["BillingAddresses"],
        shippingAddressId: json["ShippingAddressId"],
        shippingAddressUser: billingAddressUserValues.map[json["ShippingAddressUser"]],
        shippingAddresses: json["ShippingAddresses"],
        isPickUpPoint: json["IsPickUpPoint"],
        createdOn: json["CreatedOn"],
        updatedOn: json["UpdatedOn"],
        isDelete: json["IsDelete"],
        isFullOrderDelivered: json["IsFullOrderDelivered"],
        imageUrl: json["ImageURL"],
        status: datumStatusValues.map[json["Status"]],
        statusUpdatedOn: json["StatusUpdatedOn"],
        eWalletAmount: json["EWalletAmount"],
       orderDetails: List<OrderDetail>.from(json["OrderDetails"].map((x) => OrderDetail.fromJson(x)))
        
    );

    Map<String, dynamic> toJson() => {
        "MasterId": masterId,
        "OrderNumber": orderNumber,
        "UserId": userId,
        "UserName": billingAddressUserValues.reverse[userName],
        "MobileNo": mobileNo,
        "PaymentModeId": paymentModeId,
        "PaymentMode": paymentModeValues.reverse[paymentMode],
        "OrderDate": orderDate,
        "ShippingDate": shippingDate,
        "RequiredDate": requiredDate,
        "ShipperId": shipperId,
        "Shipper": shipperValues.reverse[shipper],
        "Freight": freight,
        "SubTotal": subTotal,
        "ShippingCharges": shippingCharges,
        "GrandTotal": grandTotal,
        "itemOrderedCount": itemOrderedCount,
        "TimeStamp": timeStamp,
        "TransactionId": transactionId,
        "TransactionStatus": messageValues.reverse[transactionStatus],
        "Fulfilled": fulfilled,
        "PaymentDate": paymentDate?.toIso8601String(),
        "BillingAddressId": billingAddressId,
        "BillingAddressUser": billingAddressUserValues.reverse[billingAddressUser],
        "BillingAddresses": billingAddresses,
        "ShippingAddressId": shippingAddressId,
        "ShippingAddressUser": billingAddressUserValues.reverse[shippingAddressUser],
        "ShippingAddresses": shippingAddresses,
        "IsPickUpPoint": isPickUpPoint,
        "CreatedOn": createdOn?.toIso8601String(),
        "UpdatedOn": updatedOn?.toIso8601String(),
        "IsDelete": isDelete,
        "IsFullOrderDelivered": isFullOrderDelivered,
        "ImageURL": imageUrl,
        "Status": datumStatusValues.reverse[status],
        "StatusUpdatedOn": statusUpdatedOn,
        "EWalletAmount": eWalletAmount,
        "OrderDetails": List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
    };
}

enum BillingAddressUser { XXX_YYY_ZZZ }

final billingAddressUserValues = EnumValues({
    "XXX YYY ZZZ": BillingAddressUser.XXX_YYY_ZZZ
});

class OrderDetail {
    OrderDetail({
        this.detailsId,
        this.orderMasterId,
        this.productId,
        this.productName,
        this.imageUrl,
        this.price,
        this.quantity,
        this.discount,
        this.total,
        this.shippingDate,
        this.billingDate,
        this.createdOn,
        this.updatedOn,
        this.isDelete,
        this.status,
        required this.isCancellable,
    });

    int ?detailsId;
    int ?orderMasterId;
    int ?productId;
    String ?productName;
    String ?imageUrl;
    double ?price;
    int ?quantity;
    double ?discount;
    double ?total;
    DateTime ?shippingDate;
    DateTime ?billingDate;
    DateTime ?createdOn;
    DateTime ?updatedOn;
    bool ?isDelete;
    OrderDetailStatus ?status;
    bool isCancellable;

    factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        detailsId: json["DetailsId"],
        orderMasterId: json["OrderMasterId"],
        productId: json["ProductId"],
        productName: json["ProductName"],
        imageUrl: json["ImageURL"],
        price: json["Price"],
        quantity: json["Quantity"],
        discount: json["Discount"],
        total: json["Total"],
        shippingDate: DateTime.parse(json["ShippingDate"]),
        billingDate: DateTime.parse(json["BillingDate"]),
        createdOn: DateTime.parse(json["CreatedOn"]),
        updatedOn: DateTime.parse(json["UpdatedOn"]),
        isDelete: json["IsDelete"],
        status: orderDetailStatusValues.map[json["Status"]],
        isCancellable: json["IsCancellable"],
    );

    Map<String, dynamic> toJson() => {
        "DetailsId": detailsId,
        "OrderMasterId": orderMasterId,
        "ProductId": productId,
        "ProductName": productName,
        "ImageURL": imageUrl,
        "Price": price,
        "Quantity": quantity,
        "Discount": discount,
        "Total": total,
        "ShippingDate": shippingDate?.toIso8601String(),
        "BillingDate": billingDate?.toIso8601String(),
        "CreatedOn": createdOn?.toIso8601String(),
        "UpdatedOn": updatedOn?.toIso8601String(),
        "IsDelete": isDelete,
        "Status": orderDetailStatusValues.reverse[status],
        "IsCancellable": isCancellable,
    };
}

enum OrderDetailStatus { EMPTY, DELIVERED }

final orderDetailStatusValues = EnumValues({
    "Delivered": OrderDetailStatus.DELIVERED,
    "": OrderDetailStatus.EMPTY
});

enum PaymentMode { ONLINE_PAYMENT }

final paymentModeValues = EnumValues({
    "Online Payment": PaymentMode.ONLINE_PAYMENT
});

enum Shipper { NEBULA }

final shipperValues = EnumValues({
    "Nebula": Shipper.NEBULA
});

enum DatumStatus { PROCESSING, DELIVERED }

final datumStatusValues = EnumValues({
    "Delivered": DatumStatus.DELIVERED,
    "Processing": DatumStatus.PROCESSING
});

enum Message { SUCCESS }

final messageValues = EnumValues({
    "Success": Message.SUCCESS
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap  = {};

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
