class getMyCartCountResponse {
 late int statusCode;
 late String message;
 late  getMyCartData data;

  getMyCartCountResponse({required this.statusCode, required this.message, required this.data});

  getMyCartCountResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'];
    data = (json['Data'] != null ? new getMyCartData.fromJson(json['Data']) : null)!;
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

class getMyCartData {
 late int sumOfQty;

  getMyCartData({required this.sumOfQty});

  getMyCartData.fromJson(Map<String, dynamic> json) {
    sumOfQty = json['SumOfQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SumOfQty'] = this.sumOfQty;
    return data;
  }
}