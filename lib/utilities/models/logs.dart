// ignore_for_file: public_member_api_docs

abstract class Log {
  Log({required this.id, required this.content, required this.createdAt});

  final String id;
  final String content;
  final DateTime createdAt;
}

class PurchaseLog extends Log {
  PurchaseLog({
    required super.id,
    required super.content,
    required super.createdAt,
    required this.purchaseId,
  });
  factory PurchaseLog.fromJson(Map<String, dynamic> json) {
    return PurchaseLog(
      id: json['id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      purchaseId: json['purchaseId'] as String,
    );
  }
  final String purchaseId;
}

class FinancialEntityLog extends Log {
  FinancialEntityLog({
    required super.id,
    required super.content,
    required super.createdAt,
    required this.financialEntityId,
  });
  factory FinancialEntityLog.fromJson(Map<String, dynamic> json) {
    return FinancialEntityLog(
      id: json['id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      financialEntityId: json['financialEntityId'] as String,
    );
  }

  final String financialEntityId;
}
