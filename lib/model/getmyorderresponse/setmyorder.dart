import 'getmyorderresponse.dart';

class SetMyOrder {
  final int id;
  final String? ordernumber;
  final String date;
  final String? shippingAddress;
  final String? subTotal;
  final String? shippingCharge;
  final String? grandTotal;
  final String? shippingTransectionId; 
  final int? isPickup; 
   List<OrderDetail> ?orderDetails;

  SetMyOrder(
      {required this.id,
      required this.ordernumber,
      required this.date,
      required this.shippingAddress,
      required this.subTotal,
      required this.shippingCharge,
      required this.grandTotal,
      required this.shippingTransectionId,
       required this.isPickup,
        required this.orderDetails,
      });
}
