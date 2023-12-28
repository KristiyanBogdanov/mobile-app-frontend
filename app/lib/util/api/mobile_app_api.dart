import 'package:flutter_dotenv/flutter_dotenv.dart';

class MobileAppApi {
  final _auth = 'auth';
  final _baseUrl = dotenv.env['MOBILE_APP_API_URL'] ?? '';

  String _createApiEndpoint(String apiPath) {
    return '$_baseUrl/$apiPath';
  }

  String signUp() {
    return _createApiEndpoint('$_auth/signup');
  }

  String signIn() {
    return _createApiEndpoint('$_auth/signin');
  }
}
