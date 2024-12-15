import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> getBuildDetails(String price, String config, String cpu, String gpu, String mode) async {
    final response = await http.post(
      Uri.parse('https://reallys.pythonanywhere.com/build'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'price': price,
        'cfg': config,
        'cpu': cpu,
        'gpu': gpu,
        'mode': mode
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load build details');
    }
  }
}
