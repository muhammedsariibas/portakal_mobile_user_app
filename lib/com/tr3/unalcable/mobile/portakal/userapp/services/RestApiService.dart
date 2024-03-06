import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/userapp/conf/Configuration.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/userapp/services/TokenService.dart';

class RestApiService {
  late String baseUrl;
  late TokenService tokenService;

  RestApiService() {
    baseUrl = Configuration.baseUrl;

    _initializeTokenService();
  }

  Future<void> _initializeTokenService() async {
    tokenService = await TokenService.getInstance();
  }

  Future<dynamic> get(String endpoint,
      [Map<String, String>? queryMap, Map<String, String>? headerMap]) async {
    String? token = await tokenService.getToken();
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data,
      [Map<String, String>? queryMap, Map<String, String>? headerMap]) async {
    String? token = await tokenService.getToken();
    print('$baseUrl$endpoint');
    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      print(e);
      throw Exception('Error: $e');
    }
  }
}
