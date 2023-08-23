import 'package:sports_app/enums/sports_league_enum.dart';
import 'config.dart';

class SportsApiConfig {
  final String baseUrl;
  final String host;
  final Map<String, String> queryParameters;
  final Map<String, String> headers;  // Added headers to the class properties

  SportsApiConfig({
    required this.baseUrl,
    required this.host,
    required this.queryParameters,
    required this.headers,  // Added headers to the constructor
  });

  static const String _apiKey = Config.sportsAppApiKey;

  static SportsApiConfig getConfigForLeague(SportsLeague sportsLeague) {
    String _baseUrl;
    String _host;
    Map<String, String> _queryParameters;

    switch (sportsLeague) {
      case SportsLeague.MLB: //TODO: remov \ 
        _baseUrl = 'https://api-baseball.p.rapidapi.com/games111';
        _host = 'api-baseball.p.rapidapi.com';
        _queryParameters = {
          'season': '2023',
          'date': DateTime.now().toIso8601String().split('T')[0],
          'league': '1'
        };
        break;
      case SportsLeague.NBA:
        _baseUrl = 'https://api-basketball.p.rapidapi.com/games111';
        _host = 'api-basketball.p.rapidapi.com';
        _queryParameters = {
          'league': '12',
          'season': '2023-2024',
          // 'date': '2023-12-25'
        };
        break;
      default:
        throw ArgumentError('Unknown SportsLeague: $sportsLeague');
    }

    final _headers = {
      'x-rapidapi-key': _apiKey,
      'x-rapidapi-host': _host,
    };

    return SportsApiConfig(
      baseUrl: _baseUrl,
      host: _host,
      queryParameters: _queryParameters,
      headers: _headers,
    );
  }
}
