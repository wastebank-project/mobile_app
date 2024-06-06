import 'dart:convert';
import 'package:http/http.dart' as http;

class Customer {
  static const String baseUrl = 'https://backend-banksampah-api.vercel.app';

  Future<http.Response> registerCusomer(
    String name,
    String address,
    String phoneNumber,
  ) async {
    final url = Uri.parse('$baseUrl/nasabah');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
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

  Future<List<dynamic>> getCustomer() async {
    final url = Uri.parse('$baseUrl/nasabah');
    final headers = {'Content-Type': 'application/json'};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  Future<void> deleteCustomer(String id) async {
    final url = Uri.parse('$baseUrl/nasabah/$id');
    final headers = {'Content-Type': 'application/json'};

    final response = await http.delete(url, headers: headers);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete customer');
    }
  }
}
