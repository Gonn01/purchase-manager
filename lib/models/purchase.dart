import 'package:purchase_manager/models/enums/exchange_rate.dart';
import 'package:purchase_manager/models/enums/purchase_type.dart';

class Purchase {
  Purchase({
    required this.id,
    required this.amountOfQuotas,
    required this.totalAmount,
    required this.amountPerQuota,
    required this.nameOfProduct,
    required this.type,
    required this.creationDate,
    required this.currency,
    this.lastCuotaDate,
    this.firstQuotaDate,
  });

  final String id;
  int amountOfQuotas;
  double totalAmount;
  double amountPerQuota;
  String nameOfProduct;
  PurchaseType type;
  DateTime creationDate;
  DateTime? firstQuotaDate;
  DateTime? lastCuotaDate;
  Currency currency;
}
