import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkCaller {
  static final String baseUrl = "https://lamprey-included-lion.ngrok-free.app";

  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final decoded = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {"success": true, "data": decoded};
      } else {
        return {
          "success": false,
          "message": decoded["message"] ?? "Registration failed",
        };
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}
