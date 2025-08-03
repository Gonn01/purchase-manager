class UserDto {
  UserDto({
    required this.id,
    required this.token,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as int,
      token: json['token'] as String,
    );
  }
  final int id;
  final String token;
}
