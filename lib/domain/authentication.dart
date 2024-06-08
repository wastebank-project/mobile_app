import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
      throw Exception(response.body);
    }
  }

  Future<Map<String, dynamic>> loginUser(
      String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      'username': username,
      'password': password,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    if (accessToken != null) {
      final url = Uri.parse('$baseUrl/auth/logout');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };
      final response = await http.post(url, headers: headers);

      if (response.statusCode != 200) {
        throw Exception('Failed to log out');
      }

      await prefs.remove('accessToken');
      await prefs.remove('username');
      await prefs.remove('email');
    }
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }
}
