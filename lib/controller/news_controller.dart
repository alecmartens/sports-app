import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/news_model.dart';
import '../config/config.dart';

class NewsController {
  static const _endpoint = 'https://newsapi.org/v2/top-headlines';
  static const _apiKey = Config.newsApiKey;

  Future<List<NewsArticle>> fetchNews() async {
    final url =
        Uri.parse('$_endpoint?country=us&category=sports&apiKey=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<dynamic> articlesJson = jsonData['articles'];
      return articlesJson.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news articles');
    }
  }
}
