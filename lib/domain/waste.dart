import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Waste {
  Future<http.Response> newWaste(
    String name,
    String pricePerGram,
  ) async {
    final url = Uri.parse('${dotenv.env['BASE_URL_BACKEND']}/wastetypes');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'name': name,
      'pricePerGram': pricePerGram,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      return response;
    } else {
      throw Exception(response.body);
    }
  }

  Future<List<dynamic>> getWaste() async {
    final url = Uri.parse('${dotenv.env['BASE_URL_BACKEND']}/wastetypes');
    final headers = {'Content-Type': 'application/json'};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  Future<http.Response> updateWaste(
    String id,
    String name,
    String pricePerGram,
  ) async {
    final url = Uri.parse('${dotenv.env['BASE_URL_BACKEND']}/wastetypes/$id');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'name': name,
      'pricePerGram': pricePerGram,
    });

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to update Waste');
    }
  }

  Future<void> deleteWaste(String id) async {
    final url = Uri.parse('${dotenv.env['BASE_URL_BACKEND']}/wastetypes/$id');
    final headers = {'Content-Type': 'application/json'};

    final response = await http.delete(url, headers: headers);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete customer');
    }
  }
}
