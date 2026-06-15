import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Future<String?> detectarEjercicio(String imagePath) async {
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse("http://192.168.26.3:8000/upload"),
      );

      request.files.add(await http.MultipartFile.fromPath("file", imagePath));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();

        final data = jsonDecode(responseBody);

        return data["ejercicio"];
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<Map<String, dynamic>?> contarEjercicio(
    String imagePath,
    String endpoint,
  ) async {
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse("http://192.168.26.3:8000$endpoint"),
      );

      request.files.add(await http.MultipartFile.fromPath("file", imagePath));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();

        return jsonDecode(responseBody);
      }
    } catch (e) {
      print(e);
    }

    return null;
  }
}
