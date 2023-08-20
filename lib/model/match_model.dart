import 'country_model.dart';
import 'league_model.dart';
import 'match_team_model.dart';
import 'team_score_model.dart';
import 'match_status_model.dart';

class Match {
  final int id;
  final String date;
  final String time;
  final int timestamp;
  final String timezone;
  final String statusLong;
  final String statusShort;
  final Country country;
  final League league;
  final MatchTeam homeTeam;
  final MatchTeam awayTeam;
  final TeamScore scores;
  TeamScore homeScore;
  TeamScore awayScore;
  final MatchStatus status;

  Match({
    required this.id,
    required this.date,
    required this.time,
    required this.timestamp,
    required this.timezone,
    required this.statusLong,
    required this.statusShort,
    required this.country,
    required this.league,
    required this.homeTeam,
    required this.awayTeam,
    required this.scores,
    required this.homeScore,
    required this.awayScore,
    required this.status,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'] ?? 0,
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      timestamp: json['timestamp'] ?? 0,
      timezone: json['timezone'] ?? '',
      statusLong: json['status']['long'] ?? '',
      statusShort: json['status']['short'] ?? '',
      country: Country.fromJson(json['country']),
      league: League.fromJson(json['league']),
      homeTeam: MatchTeam.fromJson(json['teams']['home']),
      awayTeam: MatchTeam.fromJson(json['teams']['away']),
      scores: TeamScore.fromJson(json['scores']),
      homeScore: TeamScore.fromJson(json['scores']['home']),
      awayScore: TeamScore.fromJson(json['scores']['away']),
      status: MatchStatus.fromJson(json['status']),
    );
  }
}
