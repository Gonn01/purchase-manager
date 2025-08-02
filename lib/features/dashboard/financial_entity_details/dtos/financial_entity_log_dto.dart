class FinancialEntityLogDto {
  final String id;
  final String content;
  final DateTime createdAt;

  FinancialEntityLogDto({
    required this.id,
    required this.content,
    required this.createdAt,
  });

  factory FinancialEntityLogDto.fromJson(Map<String, dynamic> json) {
    return FinancialEntityLogDto(
      id: json['id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'timestamp': createdAt.toIso8601String(),
    };
  }
}
