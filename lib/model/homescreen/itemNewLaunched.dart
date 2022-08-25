class ItemNewLaunched {
	int? statusCode;
  late	String message;
	Data? data;

	ItemNewLaunched({this.statusCode, required this.message, this.data});

	ItemNewLaunched.fromJson(Map<String, dynamic> json) {
		statusCode = json['StatusCode'];
		message = json['Message'];
		data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['StatusCode'] = this.statusCode;
		data['Message'] = this.message;
		if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
		return data;
	}
}

class Data {
	int? totalRecord;
	late List<itemNewLaunchedProduct> products;

	Data({this.totalRecord, required this.products});

	Data.fromJson(Map<String, dynamic> json) {
		totalRecord = json['TotalRecord'];
		if (json['Products'] != null) {
			products = <itemNewLaunchedProduct>[];
			json['Products'].forEach((v) { products!.add(new itemNewLaunchedProduct.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['TotalRecord'] = this.totalRecord;
		if (this.products != null) {
      data['Products'] = this.products!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class itemNewLaunchedProduct {
 late  int  id;
	int? projectId;
	late int productId;
  late	int categoryId;
	String? categoryName;
	int? pDetailsId;
	int? cartId;
	String? name;
	String? description;
	String? sKU;
	int? comboID;
 late	double mRP;
	double? salePrice;
	double? distributorPrice;
	double? saving;
	String? savingString;
	int? quantity;
	int? maxSaleQuantity;
	bool? inStock;
	bool? isComboProduct;
	String? returnPolicy;
	String? warranty;
	String? mainImage;
	String? thumbnailImage;
	String? weight;
	String? dimension;
	String? manufacturer;
	String? volWt;
	double? pV;
	String? pVString;
	double? bV;
	String? bVString;
	double? nV;
	String? nVString;
	int? displayOrder;
	String? shortDescription;
	double? taxRate;
	double? taxAmount;
	double? total;
	double? discount;
	bool? isCancellable;
	bool? showShareLink;
	double? averageRating;
	bool? showInNebPro;
	
	itemNewLaunchedProduct({required this.id, this.projectId, required this.productId, required this.categoryId, this.categoryName, this.pDetailsId, this.cartId, this.name, this.description, this.sKU, this.comboID, required this.mRP, this.salePrice, this.distributorPrice, this.saving, this.savingString, this.quantity, this.maxSaleQuantity, this.inStock, this.isComboProduct, this.returnPolicy, this.warranty, this.mainImage, this.thumbnailImage, this.weight, this.dimension, this.manufacturer, this.volWt, this.pV, this.pVString, this.bV, this.bVString, this.nV, this.nVString, this.displayOrder, this.shortDescription, this.taxRate, this.taxAmount, this.total, this.discount,this.isCancellable, this.showShareLink, this.averageRating, this.showInNebPro, eComProductDetailsModel});

	itemNewLaunchedProduct.fromJson(Map<String, dynamic> json) {
		id = json['Id'];
		projectId = json['ProjectId'];
		productId = json['ProductId'];
		categoryId = json['CategoryId'];
		categoryName = json['CategoryName'];
		pDetailsId = json['PDetailsId'];
		cartId = json['CartId'];
		name = json['Name'];
		description = json['Description'];
		sKU = json['SKU'];
		comboID = json['ComboID'];
		mRP = json['MRP'];
		salePrice = json['SalePrice'];
		distributorPrice = json['DistributorPrice'];
		saving = json['Saving'];
		savingString = json['SavingString'];
		quantity = json['Quantity'];
		maxSaleQuantity = json['MaxSaleQuantity'];
		inStock = json['InStock'];
		isComboProduct = json['IsComboProduct'];
		returnPolicy = json['ReturnPolicy'];
		warranty = json['Warranty'];
		mainImage = json['MainImage'];
		thumbnailImage = json['ThumbnailImage'];
		weight = json['Weight'];
		dimension = json['Dimension'];
		manufacturer = json['Manufacturer'];
		volWt = json['VolWt'];
		pV = json['PV'];
		pVString = json['PVString'];
		bV = json['BV'];
		bVString = json['BVString'];
		nV = json['NV'];
		nVString = json['NVString'];
		displayOrder = json['DisplayOrder'];
		shortDescription = json['ShortDescription'];
		taxRate = json['TaxRate'];
		taxAmount = json['TaxAmount'];
		total = json['Total'];
		discount = json['Discount'];
		isCancellable = json['IsCancellable'];
		showShareLink = json['ShowShareLink'];
		averageRating = json['AverageRating'];
		showInNebPro = json['ShowInNebPro'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Id'] = this.id;
		data['ProjectId'] = this.projectId;
		data['ProductId'] = this.productId;
		data['CategoryId'] = this.categoryId;
		data['CategoryName'] = this.categoryName;
		data['PDetailsId'] = this.pDetailsId;
		data['CartId'] = this.cartId;
		data['Name'] = this.name;
		data['Description'] = this.description;
		data['SKU'] = this.sKU;
		data['ComboID'] = this.comboID;
		data['MRP'] = this.mRP;
		data['SalePrice'] = this.salePrice;
		data['DistributorPrice'] = this.distributorPrice;
		data['Saving'] = this.saving;
		data['SavingString'] = this.savingString;
		data['Quantity'] = this.quantity;
		data['MaxSaleQuantity'] = this.maxSaleQuantity;
		data['InStock'] = this.inStock;
		data['IsComboProduct'] = this.isComboProduct;
		data['ReturnPolicy'] = this.returnPolicy;
		data['Warranty'] = this.warranty;
		data['MainImage'] = this.mainImage;
		data['ThumbnailImage'] = this.thumbnailImage;
		data['Weight'] = this.weight;
		data['Dimension'] = this.dimension;
		data['Manufacturer'] = this.manufacturer;
		data['VolWt'] = this.volWt;
		data['PV'] = this.pV;
		data['PVString'] = this.pVString;
		data['BV'] = this.bV;
		data['BVString'] = this.bVString;
		data['NV'] = this.nV;
		data['NVString'] = this.nVString;
		data['DisplayOrder'] = this.displayOrder;
		data['ShortDescription'] = this.shortDescription;
		data['TaxRate'] = this.taxRate;
		data['TaxAmount'] = this.taxAmount;
		data['Total'] = this.total;
		data['Discount'] = this.discount;
		data['IsCancellable'] = this.isCancellable;
		data['ShowShareLink'] = this.showShareLink;
		data['AverageRating'] = this.averageRating;
		data['ShowInNebPro'] = this.showInNebPro;
		return data;
	}
}