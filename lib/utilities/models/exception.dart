/// {@template CustomException}
/// Base class for custom exceptions.
/// {@endtemplate}
class CustomException implements Exception {
  /// {@macro CustomException}
  const CustomException({
    required this.title,
    required this.message,
    this.stack,
  });

  /// Error title.
  final String? title;

  /// Error message.
  final String? message;

  /// Stack trace of the error.
  final String? stack;
}
