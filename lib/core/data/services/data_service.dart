import 'dart:convert';
import 'package:http/http.dart' as http;

class DataService {
  // Base URL Deezer + proxy CORS già inclusi
  static const String _baseUrl = 'https://corsproxy.io/?https://api.deezer.com';

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final response = await http.get(_uri(endpoint), headers: headers);
    return _parse(response);
  }

  Future<dynamic> post(String endpoint, {Map<String, String>? headers, dynamic body}) async {
    final response = await http.post(
      _uri(endpoint),
      headers: headers ?? {'Content-Type': 'application/json'},
      body: body == null ? null : jsonEncode(body),
    );
    return _parse(response);
  }

  Future<dynamic> put(String endpoint, {Map<String, String>? headers, dynamic body}) async {
    final response = await http.put(
      _uri(endpoint),
      headers: headers ?? {'Content-Type': 'application/json'},
      body: body == null ? null : jsonEncode(body),
    );
    return _parse(response);
  }

  Future<dynamic> delete(String endpoint, {Map<String, String>? headers}) async {
    final response = await http.delete(_uri(endpoint), headers: headers);
    return _parse(response);
  }

  Uri _uri(String endpoint) {
    return Uri.parse('$_baseUrl$endpoint');
  }

  dynamic _parse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    }
    throw Exception('Errore ${response.statusCode}: ${response.reasonPhrase}');
  }
}
