import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:purchase_manager/utilities/models/exception.dart';
import 'package:purchase_manager/utilities/models/ld_response.dart';
import 'package:purchase_manager/utilities/models/status.dart';

/// {@template Repository}
/// Base class for repositories
/// {@endtemplate}
abstract class Repository {
  /// Manejo de excepciones personalizadas
  static Never handleException(Object e, StackTrace st) {
    if (e is TypeError) {
      throw CustomException(
        title: 'Error de tipo',
        message: 'Error de tipo ${e.runtimeType}: $e',
        stack: st.toString(),
      );
    }
    if (e.runtimeType != CustomException) {
      throw CustomException(
        title: 'Error runtime',
        message: 'Error runtime ${e.runtimeType}: $e',
        stack: st.toString(),
      );
    }

    final error = e as CustomException;

    return switch (e.runtimeType) {
      _ => throw CustomException(
          title: error.title,
          message: error.message,
          stack: '\n\n${error.stack}\n\n $st',
        ),
    };
  }

  /// Manejo de la respuesta HTTP con tipado genérico
  static ResponseLD<T> handleResponse<T>(
    http.Response response,
    ResponseLD<T> fromJson,
    Map<String, dynamic> jsonData,
  ) {
    if (Status.isClientError(response.statusCode) ||
        Status.isServerError(response.statusCode)) {
      throw CustomException(
        title: jsonData['title'] != null
            ? jsonData['title'] as String
            : 'Error HTTP',
        message: 'Error HTTP ${response.statusCode}: ${jsonData['message']}',
        stack: jsonData['stack'] as String?,
      );
    }
    return fromJson;
  }

  /// Método para realizar una petición POST a la API
  static Future<ResponseLD<T>> post<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? body,
  }) async {
    try {
      final urlUri = Uri.parse(url);
      final response = await http.post(
        urlUri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      final result = handleResponse(
        response,
        ResponseLD.fromJson(
          jsonData,
          (json) => fromJson(json),
        ),
        jsonData,
      );

      return result;
    } catch (e, stackTrace) {
      handleException(e, stackTrace);
    }
  }

  /// Método para realizar una petición GET a la API
  static Future<ResponseLD<T>> get<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final urlUri = Uri.parse(url);
      final response = await http.get(
        urlUri,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      final result = handleResponse(
        response,
        ResponseLD.fromJson(
          jsonData,
          (json) => fromJson(json),
        ),
        jsonData,
      );

      return result;
    } catch (e, stackTrace) {
      handleException(e, stackTrace);
    }
  }

  /// Método para realizar una petición PUT a la API
  static Future<ResponseLD<T>> put<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? body,
  }) async {
    try {
      final urlUri = Uri.parse(url);
      final response = await http.put(
        urlUri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      final result = handleResponse(
        response,
        ResponseLD.fromJson(
          jsonData,
          (json) => fromJson(json),
        ),
        jsonData,
      );

      return result;
    } catch (e, stackTrace) {
      handleException(e, stackTrace);
    }
  }

  /// Método para realizar una petición DELETE a la API
  static Future<ResponseLD<T>> delete<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final urlUri = Uri.parse(url);
      final response = await http.delete(
        urlUri,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      final result = handleResponse(
        response,
        ResponseLD.fromJson(
          jsonData,
          (json) => fromJson(json),
        ),
        jsonData,
      );

      return result;
    } catch (e, stackTrace) {
      handleException(e, stackTrace);
    }
  }
}
