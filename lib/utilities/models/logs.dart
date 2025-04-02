// ignore_for_file: public_member_api_docs

abstract class Log {
  Log({required this.id, required this.content, required this.createdAt});

  final int id;
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
      id: json['id'] as int,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      purchaseId: json['purchase_id'] as int,
    );
  }
  final int purchaseId;
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
      id: json['id'] as int,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      financialEntityId: json['financialEntityId'] as int,
    );
  }

  final int financialEntityId;
}
