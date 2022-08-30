class GetOrderListResponse {
late  int statusCode;
 late String message;
 late List<Data> data;

  GetOrderListResponse({required this.statusCode, required this.message, required this.data});

  GetOrderListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['Data'] != null) {
      // ignore: deprecated_member_use
      data = <Data>[];
      json['Data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['StatusCode'] = this.statusCode;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
late  int masterId;
late  String orderNumber;
 late String userId;
 late String userName;
 late String mobileNo;
 late int paymentModeId;
 late  String paymentMode;
 late int orderDate;
 late String requiredDate;
 late int shipperId;
 late String shipper;
 late int freight;
 late int subTotal;
 late int shippingCharges;
 late int grandTotal;
 late int itemOrderedCount;
 late String timeStamp;
 late String transactionId;
 late  String transactionStatus;
 late bool fulfilled;
 late String paymentDate;
 late int billingAddressId;
 late String billingAddressUser;
 late String billingAddresses;
 late int shippingAddressId;
 late String shippingAddressUser;
 late String shippingAddresses;
 late int isPickUpPoint;
 late String createdOn;
 late  String updatedOn;
 late bool isDelete;
 late  bool isFullOrderDelivered;
 late String imageURL;
 late String status;
 late String statusUpdatedOn;
 late int eWalletAmount;
  late List<OrderDetails> orderDetails;

  Data(
      {required this.masterId,
      required this.orderNumber,
      required this.userId,
      required this.userName,
      required this.mobileNo,
      required this.paymentModeId,
      required this.paymentMode,
      required this.orderDate,
      required this.requiredDate,
      required this.shipperId,
      required this.shipper,
      required this.freight,
      required this.subTotal,
      required this.shippingCharges,
      required this.grandTotal,
      required this.itemOrderedCount,
      required this.timeStamp,
      required this.transactionId,
      required this.transactionStatus,
      required this.fulfilled,
      required this.paymentDate,
      required this.billingAddressId,
      required this.billingAddressUser,
      required this.billingAddresses,
      required this.shippingAddressId,
      required this.shippingAddressUser,
      required this.shippingAddresses,
      required this.isPickUpPoint,
      required this.createdOn,
      required this.updatedOn,
      required this.isDelete,
      required this.isFullOrderDelivered,
      required this.imageURL,
      required this.status,
      required this.statusUpdatedOn,
      required this.eWalletAmount,
      required this.orderDetails});

  Data.fromJson(Map<String, dynamic> json) {
    masterId = json['MasterId'];
    orderNumber = json['OrderNumber'];
    userId = json['UserId'];
    userName = json['UserName'];
    mobileNo = json['MobileNo'];
    paymentModeId = json['PaymentModeId'];
    paymentMode = json['PaymentMode'];
    orderDate = json['OrderDate'];
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
      // ignore: deprecated_member_use
      orderDetails = <OrderDetails>[];
      json['OrderDetails'].forEach((v) {
        orderDetails.add(OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['MasterId'] = this.masterId;
    data['OrderNumber'] = this.orderNumber;
    data['UserId'] = this.userId;
    data['UserName'] = this.userName;
    data['MobileNo'] = this.mobileNo;
    data['PaymentModeId'] = this.paymentModeId;
    data['PaymentMode'] = this.paymentMode;
    data['OrderDate'] = this.orderDate;
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
      data['OrderDetails'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
 late int detailsId;
 late int orderMasterId;
 late int productId;
 late String productName;
late  String imageURL;
late  int price;
 late int quantity;
  late int discount;
late  int total;
 late String shippingDate;
 late String billingDate;
late  String createdOn;
late  String updatedOn;
late  bool isDelete;
 late String status;
late  bool isCancellable;

  OrderDetails(
      {required this.detailsId,
      required this.orderMasterId,
      required this.productId,
      required this.productName,
     required this.imageURL,
     required this.price,
     required this.quantity,
     required this.discount,
    required  this.total,
   required   this.shippingDate,
     required this.billingDate,
    required  this.createdOn,
    required  this.updatedOn,
    required  this.isDelete,
     required this.status,
     required this.isCancellable});

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
    final Map<String, dynamic> data = Map<String, dynamic>();
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