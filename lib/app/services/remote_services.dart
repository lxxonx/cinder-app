import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RemoteServices {
  static var client = http.Client();

  static var env = dotenv.env['ENV'] ?? 'dev';
}
