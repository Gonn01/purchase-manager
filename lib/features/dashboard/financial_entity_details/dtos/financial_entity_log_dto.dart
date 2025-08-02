class FinancialEntityLogDto {
  FinancialEntityLogDto({
    required this.id,
    required this.content,
    required this.createdAt,
  });

  factory FinancialEntityLogDto.fromJson(Map<String, dynamic> json) {
    return FinancialEntityLogDto(
      id: json['id'] as int,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
  final int id;
  final String content;
  final DateTime createdAt;
}
