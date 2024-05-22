/// {@template PurchaseType}
/// Enumeración que representa el tipo de compra.
///
/// Enumeration representing the type of purchase.
/// {@endtemplate}
enum PurchaseType {
  /// Compra vigente deudora.
  ///
  /// Current debtor purchase.
  currentDebtorPurchase,

  /// Compra vigente acreedora.
  ///
  /// Current creditor purchase.
  currentCreditorPurchase,

  /// Compra saldada deudora.
  ///
  /// Settled debtor purchase.
  settledDebtorPurchase,

  /// Compra saldada acreedora.
  ///
  /// Settled creditor purchase.
  settledCreditorPurchase;

  /// Devuelve un [PurchaseType] a partir de un valor entero.
  ///
  /// Returns a [PurchaseType] from an integer value.
  static PurchaseType type(int value) {
    return switch (value) {
      0 => PurchaseType.currentDebtorPurchase,
      1 => PurchaseType.currentCreditorPurchase,
      2 => PurchaseType.settledDebtorPurchase,
      3 => PurchaseType.settledCreditorPurchase,
      _ => throw Exception('Invalid purchase type'),
    };
  }

  /// Devuelve el valor entero del tipo de compra.
  ///
  /// Returns the integer value of the purchase type.
  int get value => switch (this) {
        PurchaseType.currentDebtorPurchase => 0,
        PurchaseType.currentCreditorPurchase => 1,
        PurchaseType.settledDebtorPurchase => 2,
        PurchaseType.settledCreditorPurchase => 3,
      };

  /// Devuelve si el [PurchaseType] es actual.
  ///
  /// Returns if the [PurchaseType] is current.
  bool get isCurrent => switch (this) {
        PurchaseType.currentDebtorPurchase ||
        PurchaseType.currentCreditorPurchase =>
          true,
        _ => false,
      };

  /// Devuelve si el [PurchaseType] es deudor.
  ///
  /// Returns if the [PurchaseType] is debtor.
  bool get isDebtor => switch (this) {
        PurchaseType.currentDebtorPurchase ||
        PurchaseType.settledDebtorPurchase =>
          true,
        _ => false,
      };
}
