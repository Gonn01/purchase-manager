import 'package:purchase_manager/utilities/models/custom_exception.dart';

/// {@template ResponseLD}
/// Generic response model
/// {@endtemplate}
class PMResponse<T> {
  /// {@macro ResponseLD}
  PMResponse({
    required this.message,
    required this.body,
    this.success,
  });

  /// Create a [PMResponse] from json
  factory PMResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    try {
      return PMResponse(
        success: json['success'] != null ? json['success'] as bool : null,
        body: fromJsonT(json['body']),
        message: json['message'] as String,
      );
    } on CustomException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  /// The response status
  final bool? success;

  /// The response body
  final T body;

  /// The response message
  final String? message;

  /// Copy the current [PMResponse] with some changes
  PMResponse<T> copyWith({
    bool? estadoRespuesta,
    T? body,
    String? message,
  }) {
    return PMResponse(
      success: success ?? this.success,
      body: body ?? this.body,
      message: message,
    );
  }

  @override
  String toString() =>
      'ResponseLD(success: $success, body: $body, message: $message)';
}
