// config.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get apiUrl =>
      dotenv.env['API_URL'] ??
      'https://api-purchase-manager.netlify.app/.netlify/functions/server';
}
