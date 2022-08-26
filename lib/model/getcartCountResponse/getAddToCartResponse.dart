class GetAddToCartResponse {
  int? statusCode;
  String? message;
  int? data;

  GetAddToCartResponse({this.statusCode, this.message, this.data});

  GetAddToCartResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'];
    data = json['Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusCode'] = this.statusCode;
    data['Message'] = this.message;
    data['Data'] = this.data;
    return data;
  }
}