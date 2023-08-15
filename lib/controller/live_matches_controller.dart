import 'package:http/http.dart' as http;
import 'dart:convert';
import '../enums/sports_league_enum.dart';
import 'package:flutter/material.dart';
import '../model/match_model.dart'; // Import your Match model

class LiveMatchesController {
  final SportsLeague sportsLeague;
  final String apiKey;

  LiveMatchesController({required this.sportsLeague, required this.apiKey});

  Future<List<Match>> fetchLiveMatches() async {
    late final String baseUrl;

    switch (sportsLeague) {
      case SportsLeague.MLB:
        baseUrl = 'https://api.sportsradar.us/mlb/trial/v7/en/games';
        break;
      case SportsLeague.NFL:
        baseUrl = 'https://api.sportsradar.us/nfl/trial/v7/en/games';
        break;
      case SportsLeague.NBA:
        baseUrl = 'https://api.sportsradar.us/nba/trial/v7/en/games';
        break;
      case SportsLeague.NHL:
        baseUrl = 'https://api.sportsradar.us/nhl/trial/v7/en/games';
        break;
    }

    final queryParams = {'api_key': apiKey};
    final response = await http.get(Uri.parse(baseUrl).replace(queryParameters: queryParams));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final matches = data['games'];

      return matches.map<Match>((matchData) => Match.fromJson(matchData)).toList();
    } else {
      throw Exception('Failed to fetch live matches');
    }
  }
}
