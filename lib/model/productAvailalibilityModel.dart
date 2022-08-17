class ProductAvailabilityModel {
  final int id;
  final int productid;
  final int catid;
  final String company;
  final String name;
  final String icon;
  final int remainingQuantity;
  final int? qunatity;


  ProductAvailabilityModel(
      {required this.id,
      required this.productid,
      required this.catid,
      required this.company,
      required this.name,
      required this.icon,
      required this.remainingQuantity,
      required this.qunatity});
}
