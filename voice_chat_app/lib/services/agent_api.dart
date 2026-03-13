import 'dart:convert';
import 'package:http/http.dart' as http;

class AgentAPI {

  final String baseUrl = "http://127.0.0.1:8000/chat";

  Future<String> sendMessage(String message) async {

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "message": message
      }),
    );

    final data = jsonDecode(response.body);

    return data["response"];
  }
}