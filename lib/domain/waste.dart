import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Waste {
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
}
