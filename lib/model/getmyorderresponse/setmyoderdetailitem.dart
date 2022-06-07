import 'getmyorderresponse.dart';

class SetMyOrderDetailItem{
  final int id;
  final String? productimage;
  final String ?productname;
  final String? price;
  final String? qunatity;
  final bool is_Cancelled;

  SetMyOrderDetailItem(
      {required this.id,
      required this.productimage,
      required this.productname,
      required this.price,
      required this.qunatity,
     required this.is_Cancelled
      });
}
