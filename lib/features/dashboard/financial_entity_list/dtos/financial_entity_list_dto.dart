class FinancialEntityDto {
  const FinancialEntityDto({
    required this.id,
    required this.name,
  });
  factory FinancialEntityDto.fromJson(Map<String, dynamic> json) {
    return FinancialEntityDto(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  final int id;
  final String name;
}
