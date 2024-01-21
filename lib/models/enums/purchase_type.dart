enum PurchaseType {
  currentDebtorPurchase,
  currentCreditorPurchase,
  settledDebtorPurchase,
  settledCreditorPurchase;

  static PurchaseType type(int value) {
    return switch (value) {
      0 => PurchaseType.currentDebtorPurchase,
      1 => PurchaseType.currentCreditorPurchase,
      2 => PurchaseType.settledDebtorPurchase,
      3 => PurchaseType.settledCreditorPurchase,
      _ => throw Exception('Invalid purchase type'),
    };
  }

  int get value => switch (this) {
        PurchaseType.currentDebtorPurchase => 0,
        PurchaseType.currentCreditorPurchase => 1,
        PurchaseType.settledDebtorPurchase => 2,
        PurchaseType.settledCreditorPurchase => 3,
      };

  bool get isCurrent => switch (this) {
        PurchaseType.currentDebtorPurchase ||
        PurchaseType.currentCreditorPurchase =>
          true,
        _ => false,
      };

  bool get isDebtor => switch (this) {
        PurchaseType.currentDebtorPurchase ||
        PurchaseType.settledDebtorPurchase =>
          true,
        _ => false,
      };
}
