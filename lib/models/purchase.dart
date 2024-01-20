class Purchase {
  Purchase({
    required this.id,
    required this.amountOfQuotas,
    required this.totalAmount,
    required this.amountPerQuota,
    required this.nameOfProduct,
    required this.current,
    required this.debt,
    required this.creationDate,
    this.lastCuotaDate,
    this.firstQuotaDate,
  });

  final String id;
  int amountOfQuotas;
  double totalAmount;
  double amountPerQuota;
  String nameOfProduct;
  bool current;
  bool debt;
  DateTime creationDate;
  DateTime? firstQuotaDate;
  DateTime? lastCuotaDate;
}
