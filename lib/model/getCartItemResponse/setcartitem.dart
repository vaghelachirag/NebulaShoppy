class SetCartItem {
  final int id;
  final int productid;
  final String name;
  final String desc;
  final String icon;
  final String price;
  final String pv;
  final String nv;
  final String bv; 
  final int  int_cartQuntity; 
  final bool is_Free ;
  final String rankRewardText ;
 

  SetCartItem(
      {required this.id,
      required this.productid,
      required this.name,
      required this.desc,
      required this.icon,
      required this.price,
      required this.pv,
      required this.nv,
      required this.bv,
      required this.int_cartQuntity,required this.is_Free,required this.rankRewardText});
}
