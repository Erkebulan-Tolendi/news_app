import 'dart:convert';

import 'package:http/http.dart' as http;

class TmdbApi {
  static const String apiKey = '5d41a68065896b7cca1e416cda8e4d27';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<dynamic>> fetchNews(int page) async {
    final response = await http
        .get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&page=$page'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['results'];
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<Map<String, dynamic>> fetchNewsDetails(int id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/movie/$id?api_key=$apiKey'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load news details');
    }
  }
}
