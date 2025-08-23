class FinancialEntityListDto {
  const FinancialEntityListDto({
    required this.id,
    required this.name,
  });
  factory FinancialEntityListDto.fromJson(Map<String, dynamic> json) {
    return FinancialEntityListDto(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  final int id;
  final String name;
}
