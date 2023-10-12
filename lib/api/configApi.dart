import 'dart:convert';
import 'package:http/http.dart' as http;

class ConfigApi {
  final String baseUrl;

  ConfigApi(this.baseUrl);

  Future<dynamic> postRequest(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return (response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}