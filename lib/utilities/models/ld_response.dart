import 'package:purchase_manager/utilities/models/exception.dart';

/// {@template ResponseLD}
/// Generic response model
/// {@endtemplate}
class ResponseLD<T> {
  /// {@macro ResponseLD}
  const ResponseLD({
    required this.message,
    this.success,
    this.body,
  });

  /// Create a [ResponseLD] from json
  factory ResponseLD.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) fromJsonT,
  ) {
    try {
      return ResponseLD(
        success: json['success'] != null ? json['success'] as bool : null,
        body: json['body'] != null ? fromJsonT(json) : null,
        message: json['message'] as String,
      );
    } catch (e, st) {
      throw CustomException(
        title: 'Error en la respuesta',
        message: 'Error al parsear la respuesta: $e',
        stack: st.toString(),
      );
    }
  }

  /// The response status
  final bool? success;

  /// The response body
  final T? body;

  /// The response message
  final String? message;

  /// Copy the current [ResponseLD] with some changes
  ResponseLD<T> copyWith({
    bool? estadoRespuesta,
    T? body,
    String? message,
  }) {
    return ResponseLD(
      success: success ?? this.success,
      body: body ?? this.body,
      message: message,
    );
  }

  @override
  String toString() =>
      'ResponseLD(success: $success, body: $body, message: $message)';
}
