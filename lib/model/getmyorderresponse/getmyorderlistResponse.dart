class getMyOrderListResponse {
  int? statusCode;
  String? message;
  List<Data>? data;

  getMyOrderListResponse({this.statusCode, this.message, this.data});

  getMyOrderListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? masterId;
  String? orderNumber;
  String? userId;
  String? userName;
  String? mobileNo;
  int? paymentModeId;
  String? paymentMode;
  int? orderDate;
  Null? shippingDate;
  String? requiredDate;
  int? shipperId;
  String? shipper;
  double? freight;
  double? subTotal;
  double? shippingCharges;
  double? grandTotal;
  int? itemOrderedCount;
  String? timeStamp;
  String? transactionId;
  String? transactionStatus;
  bool? fulfilled;
  String? paymentDate;
  int? billingAddressId;
  String? billingAddressUser;
  String? billingAddresses;
  int? shippingAddressId;
  String? shippingAddressUser;
  String? shippingAddresses;
  int? isPickUpPoint;
  String? createdOn;
  String? updatedOn;
  bool? isDelete;
  bool? isFullOrderDelivered;
  String? imageURL;
  String? status;
  String? statusUpdatedOn;
  double? eWalletAmount;
  List<OrderDetails>? orderDetails;

  Data(
      {this.masterId,
      this.orderNumber,
      this.userId,
      this.userName,
      this.mobileNo,
      this.paymentModeId,
      this.paymentMode,
      this.orderDate,
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
      this.imageURL,
      this.status,
      this.statusUpdatedOn,
      this.eWalletAmount,
      this.orderDetails});

  Data.fromJson(Map<String, dynamic> json) {
    masterId = json['MasterId'];
    orderNumber = json['OrderNumber'];
    userId = json['UserId'];
    userName = json['UserName'];
    mobileNo = json['MobileNo'];
    paymentModeId = json['PaymentModeId'];
    paymentMode = json['PaymentMode'];
    orderDate = json['OrderDate'];
    shippingDate = json['ShippingDate'];
    requiredDate = json['RequiredDate'];
    shipperId = json['ShipperId'];
    shipper = json['Shipper'];
    freight = json['Freight'];
    subTotal = json['SubTotal'];
    shippingCharges = json['ShippingCharges'];
    grandTotal = json['GrandTotal'];
    itemOrderedCount = json['itemOrderedCount'];
    timeStamp = json['TimeStamp'];
    transactionId = json['TransactionId'];
    transactionStatus = json['TransactionStatus'];
    fulfilled = json['Fulfilled'];
    paymentDate = json['PaymentDate'];
    billingAddressId = json['BillingAddressId'];
    billingAddressUser = json['BillingAddressUser'];
    billingAddresses = json['BillingAddresses'];
    shippingAddressId = json['ShippingAddressId'];
    shippingAddressUser = json['ShippingAddressUser'];
    shippingAddresses = json['ShippingAddresses'];
    isPickUpPoint = json['IsPickUpPoint'];
    createdOn = json['CreatedOn'];
    updatedOn = json['UpdatedOn'];
    isDelete = json['IsDelete'];
    isFullOrderDelivered = json['IsFullOrderDelivered'];
    imageURL = json['ImageURL'];
    status = json['Status'];
    statusUpdatedOn = json['StatusUpdatedOn'];
    eWalletAmount = json['EWalletAmount'];
    if (json['OrderDetails'] != null) {
      orderDetails = <OrderDetails>[];
      json['OrderDetails'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MasterId'] = this.masterId;
    data['OrderNumber'] = this.orderNumber;
    data['UserId'] = this.userId;
    data['UserName'] = this.userName;
    data['MobileNo'] = this.mobileNo;
    data['PaymentModeId'] = this.paymentModeId;
    data['PaymentMode'] = this.paymentMode;
    data['OrderDate'] = this.orderDate;
    data['ShippingDate'] = this.shippingDate;
    data['RequiredDate'] = this.requiredDate;
    data['ShipperId'] = this.shipperId;
    data['Shipper'] = this.shipper;
    data['Freight'] = this.freight;
    data['SubTotal'] = this.subTotal;
    data['ShippingCharges'] = this.shippingCharges;
    data['GrandTotal'] = this.grandTotal;
    data['itemOrderedCount'] = this.itemOrderedCount;
    data['TimeStamp'] = this.timeStamp;
    data['TransactionId'] = this.transactionId;
    data['TransactionStatus'] = this.transactionStatus;
    data['Fulfilled'] = this.fulfilled;
    data['PaymentDate'] = this.paymentDate;
    data['BillingAddressId'] = this.billingAddressId;
    data['BillingAddressUser'] = this.billingAddressUser;
    data['BillingAddresses'] = this.billingAddresses;
    data['ShippingAddressId'] = this.shippingAddressId;
    data['ShippingAddressUser'] = this.shippingAddressUser;
    data['ShippingAddresses'] = this.shippingAddresses;
    data['IsPickUpPoint'] = this.isPickUpPoint;
    data['CreatedOn'] = this.createdOn;
    data['UpdatedOn'] = this.updatedOn;
    data['IsDelete'] = this.isDelete;
    data['IsFullOrderDelivered'] = this.isFullOrderDelivered;
    data['ImageURL'] = this.imageURL;
    data['Status'] = this.status;
    data['StatusUpdatedOn'] = this.statusUpdatedOn;
    data['EWalletAmount'] = this.eWalletAmount;
    if (this.orderDetails != null) {
      data['OrderDetails'] = this.orderDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  int? detailsId;
  int? orderMasterId;
  int? productId;
  String? productName;
  String? imageURL;
  double? price;
  int? quantity;
  double? discount;
  double? total;
  String? shippingDate;
  String? billingDate;
  String? createdOn;
  String? updatedOn;
  bool? isDelete;
  String? status;
  bool? isCancellable;

  OrderDetails(
      {this.detailsId,
      this.orderMasterId,
      this.productId,
      this.productName,
      this.imageURL,
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
      this.isCancellable});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    detailsId = json['DetailsId'];
    orderMasterId = json['OrderMasterId'];
    productId = json['ProductId'];
    productName = json['ProductName'];
    imageURL = json['ImageURL'];
    price = json['Price'];
    quantity = json['Quantity'];
    discount = json['Discount'];
    total = json['Total'];
    shippingDate = json['ShippingDate'];
    billingDate = json['BillingDate'];
    createdOn = json['CreatedOn'];
    updatedOn = json['UpdatedOn'];
    isDelete = json['IsDelete'];
    status = json['Status'];
    isCancellable = json['IsCancellable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DetailsId'] = this.detailsId;
    data['OrderMasterId'] = this.orderMasterId;
    data['ProductId'] = this.productId;
    data['ProductName'] = this.productName;
    data['ImageURL'] = this.imageURL;
    data['Price'] = this.price;
    data['Quantity'] = this.quantity;
    data['Discount'] = this.discount;
    data['Total'] = this.total;
    data['ShippingDate'] = this.shippingDate;
    data['BillingDate'] = this.billingDate;
    data['CreatedOn'] = this.createdOn;
    data['UpdatedOn'] = this.updatedOn;
    data['IsDelete'] = this.isDelete;
    data['Status'] = this.status;
    data['IsCancellable'] = this.isCancellable;
    return data;
  }
}