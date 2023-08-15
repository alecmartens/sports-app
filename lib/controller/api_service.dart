import 'package:http/http.dart' as http;
import '../enums/sports_league_enum.dart';

class ApiService {
  static Future<http.Response> fetchMatches(SportsLeague sportsLeague) async {
    final String apiKey = '3600678522msh93f2d9232f71c63p11e517jsn853942a57f3e';
    late final String baseUrl;

    switch (sportsLeague) {
      case SportsLeague.MLB:
        baseUrl = 'https://api-baseball.p.rapidapi.com/games';
        break;
      case SportsLeague.NFL:
        // baseUrl = 'YOUR_NFL_API_ENDPOINT';
        break;
      case SportsLeague.NBA:
        baseUrl = 'https://api-basketball.p.rapidapi.com/games';
        break;
      case SportsLeague.NHL:
        // baseUrl = 'YOUR_NHL_API_ENDPOINT';
        break;
    }

    final headers = {
      'x-rapidapi-key': apiKey,
      'x-rapidapi-host': 'api-baseball.p.rapidapi.com',
    };

    final Map<String, String> queryParameters = {
      'season': '2023',
      'date': '2023-08-15',
      'league': '1'
    };

    final response = await http.get(
      Uri.parse(baseUrl).replace(queryParameters: queryParameters),
      headers: headers,
    );

    return response;
  }
}
