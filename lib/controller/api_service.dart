import 'dart:convert';
import 'package:http/http.dart' as http;
import '../enums/sports_league_enum.dart';
import '../model/match_model.dart';
import 'package:sports_app/config/sports_api_config.dart';
// Add this import at the top

class ApiService {
  // final String _apiKey = Config.sportsAppApiKey;
  final http.Client httpClient;

  ApiService({http.Client? client}) : httpClient = client ?? http.Client();

  Future<List<Match>> fetchMatches(
      SportsLeague sportsLeague, String matchStatus) async {
    final response = await _fetchRawMatches(sportsLeague);
    if (sportsLeague == SportsLeague.NBA) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final matches = data['response'];

      if (matches != null && matches is List) {
        return matches
            .map<Match>((matchData) => Match.fromJson(matchData))
            .where((match) {
          if (matchStatus == 'Live') {
            return match.statusLong != 'Finished' &&
                match.statusLong != 'Not Started';
          } else if (matchStatus == 'Not Started') {
            return match.statusLong == 'Not Started';
          } else if (matchStatus == 'Finished') {
            return match.statusLong == 'Finished';
          }
          return false;
        }).toList();
      } else {
        throw Exception('Response data is null or not in expected format');
      }
    } else {
      throw Exception('Failed to fetch matches');
    }
  }

  Future<http.Response> _fetchRawMatches(SportsLeague sportsLeague) async {
    print("Using client: $httpClient");

    SportsApiConfig config = SportsApiConfig.getConfigForLeague(sportsLeague);

    return await http.get(
      Uri.parse(config.baseUrl)
          .replace(queryParameters: config.queryParameters),
      headers: config.headers,
    );
  }
}
