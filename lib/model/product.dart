class Product {
  final int id;
  final int productid;
  final int catid;
  final String company;
  final String name;
  final String icon;
  final double rating;
  final String price;
  final String mrp;
  final int remainingQuantity;

  Product(
      {required this.id,
      required this.productid,
      required this.catid,
      required this.company,
      required this.name,
      required this.icon,
      required this.rating,
      required this.price,
      required this.mrp,
      required this.remainingQuantity});
}
