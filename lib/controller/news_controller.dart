import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/news_model.dart';

class NewsController {
  // Define the API endpoint and your API key (you'll get this from NewsAPI)
  static const _endpoint = 'https://newsapi.org/v2/top-headlines';
  static const _apiKey = '718e9661db0a429ebb3ecb9fb549ae47';

  // A function to fetch news from the NewsAPI
  Future<List<NewsArticle>> fetchNews() async {
    // Construct the URL with query parameters
    final url = Uri.parse('$_endpoint?country=us&category=sports&apiKey=$_apiKey');

    // Make the HTTP GET request
    final response = await http.get(url);

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the JSON response
      var jsonData = json.decode(response.body);
      List<dynamic> articlesJson = jsonData['articles'];

      // Convert each article in the JSON to a NewsArticle object
      return articlesJson.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      // If the request failed, throw an error
      throw Exception('Failed to load news articles');
    }
  }
}
