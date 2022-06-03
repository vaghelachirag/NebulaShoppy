import 'dart:convert';

GetMyEwalletHistoryResponse getMyEwalletHistoryResponseFromJson(String str) => GetMyEwalletHistoryResponse.fromJson(json.decode(str));

String getMyEwalletHistoryResponseToJson(GetMyEwalletHistoryResponse data) => json.encode(data.toJson());

class GetMyEwalletHistoryResponse {
    GetMyEwalletHistoryResponse({
        this.statusCode,
        this.message,
        required this.data,
    });

    int ?statusCode;
    String ?message;
    List<GetEWalletHistoryData> data;

    factory GetMyEwalletHistoryResponse.fromJson(Map<String, dynamic> json) => GetMyEwalletHistoryResponse(
        statusCode: json["StatusCode"],
        message: json["Message"],
        data: List<GetEWalletHistoryData>.from(json["Data"].map((x) => GetEWalletHistoryData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class GetEWalletHistoryData {
    GetEWalletHistoryData({
        this.iboKeyId,
        this.amount,
        this.balance,
        this.transactiontype,
        this.remark,
        this.createdOn,
        this.longCreatedOn,
    });

    String ?iboKeyId;
    double ?amount;
    double ?balance;
    String ?transactiontype;
    String ?remark;
    DateTime ?createdOn;
    int ?longCreatedOn;

    factory GetEWalletHistoryData.fromJson(Map<String, dynamic> json) => GetEWalletHistoryData(
        iboKeyId: json["IBOKeyID"],
        amount: json["Amount"],
        balance: json["Balance"],
        transactiontype: json["Transactiontype"],
        remark: json["Remark"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        longCreatedOn: json["longCreatedOn"],
    );

    Map<String, dynamic> toJson() => {
        "IBOKeyID": iboKeyId,
        "Amount": amount,
        "Balance": balance,
        "Transactiontype": transactiontype,
        "Remark": remark,
        "longCreatedOn": longCreatedOn,
    };
}
