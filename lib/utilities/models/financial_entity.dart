/// {@template FinancialEntity}
/// Entidad financiera que contiene las compras
///
/// Financial entity that contains purchases
/// {@endtemplate}
class FinancialEntity {
  /// {@macro FinancialEntity}
  const FinancialEntity({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.userId,
    required this.deleted,
  });

  /// Crea una [FinancialEntity] a partir de un json
  ///
  /// Create a [FinancialEntity] from a json
  factory FinancialEntity.fromJson(Map<String, dynamic> json) {
    return FinancialEntity(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String).toLocal(),
      name: json['name'] as String,
      userId: json['user_id'] as int,
      deleted: json['deleted'] as bool,
    );
  }

  /// id de la entidad financiera
  ///
  /// id of the financial entity
  final int id;
  final DateTime createdAt;

  /// Nombre de la entidad financiera
  ///
  /// Name of the financial entity
  final String name;
  final int userId;
  final bool deleted;

  /// Copia de la entidad financiera con los nuevos valores
  ///
  /// Copy of the financial entity with the new values
  FinancialEntity copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
    int? userId,
    bool? deleted,
  }) {
    return FinancialEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      deleted: deleted ?? this.deleted,
    );
  }
}
