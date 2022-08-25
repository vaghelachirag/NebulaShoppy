class itemHomeCategory {
  int? statusCode;
  String? message;
 late List<HomeCategoryData> data;

  itemHomeCategory({this.statusCode, this.message, required this.data});

  itemHomeCategory.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'];
    if (json['Data'] != null) {
      data = <HomeCategoryData>[];
      json['Data'].forEach((v) {
        data.add(new HomeCategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusCode'] = this.statusCode;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeCategoryData {
 late int id;
  String? name;
  String? description;
  int? displayOrder;
 late  String image;

  HomeCategoryData({required this.id, this.name, this.description, this.displayOrder, required this.image});

  HomeCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    description = json['Description'];
    displayOrder = json['DisplayOrder'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['DisplayOrder'] = this.displayOrder;
    data['Image'] = this.image;
    return data;
  }
}