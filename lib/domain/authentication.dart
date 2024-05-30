import 'dart:convert';
import 'package:http/http.dart' as http;

class Authentication {
  static const String baseUrl = 'https://backend-banksampah-api.vercel.app';

  Future<http.Response> registerUser(
    String email,
    String password,
    String confirmPassword,
    String username,
  ) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'username': username,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      // Registration successful
      return response;
    } else {
      // Handle error
      throw Exception('Failed to register user: ${response.body}');
    }
  }
}
