import 'package:http/http.dart' as http;
import 'package:purchase_manager/utilities/models/pm_response.dart';

/// {@template CustomException}
/// Base class for custom exceptions.
/// {@endtemplate}
class CustomException implements Exception {
  /// {@macro CustomException}
  const CustomException({required this.message});

  /// Error message.
  final String? message;
}

/// Manejo de excepciones personalizadas
Never handleException(Object e, StackTrace st) {
  if (e is TypeError) {
    throw CustomException(
      message: 'Error de tipo ${e.runtimeType}: $e',
    );
  }
  if (e.runtimeType != CustomException) {
    throw CustomException(message: e.toString());
  }

  final error = e as CustomException;

  return switch (e.runtimeType) {
    _ => throw CustomException(message: error.message),
  };
}

/// Manejo de la respuesta HTTP con tipado genérico
PMResponse<T> handleResponse<T>(
  http.Response response,
  PMResponse<T> fromJson,
  Map<String, dynamic> jsonData,
) {
  if (response.statusCode != 200) {
    throw CustomException(
      message: 'Error HTTP ${response.statusCode}: ${jsonData['message']}',
    );
  }

  return fromJson;
}
