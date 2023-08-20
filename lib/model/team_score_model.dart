import 'dart:convert';

class TeamScore {
  final int? total;
  final Map<String, int?> quarters;
  final Map<String, int?> innings;

  TeamScore(
      {required this.total, required this.quarters, required this.innings});

  factory TeamScore.fromJson(Map<String, dynamic> json) {
    return TeamScore(
      total: json['total'],
      quarters: json['quarters'] != null
          ? {
              'quarter_1': json['quarters']['quarter_1'],
              'quarter_2': json['quarters']['quarter_2'],
              'quarter_3': json['quarters']['quarter_3'],
              'quarter_4': json['quarters']['quarter_4'],
              'over_time': json['quarters']['over_time'],
            }
          : {},
      innings: json['innings'] != null
          ? {
              'inning_1': json['innings']['inning_1'],
              'inning_2': json['innings']['inning_2'],
              'inning_3': json['innings']['inning_3'],
              'inning_4': json['innings']['inning_4'],
              'inning_5': json['innings']['inning_5'],
              'inning_6': json['innings']['inning_6'],
              'inning_7': json['innings']['inning_7'],
              'inning_8': json['innings']['inning_8'],
              'inning_9': json['innings']['inning_9'],
            }
          : {},
    );
  }

  List<TeamScore> parseTeamScores(String apiResponse) {
    final decodedJson = json.decode(apiResponse);
    final List<dynamic> games = decodedJson['response'];
    List<TeamScore> teamScores = [];

    for (var game in games) {
      TeamScore homeTeamScore = TeamScore.fromJson(game['scores']['home']);
      TeamScore awayTeamScore = TeamScore.fromJson(game['scores']['away']);

      teamScores.add(homeTeamScore);
      teamScores.add(awayTeamScore);
    }

    return teamScores;
  }

  int get points {
    if (total != null) {
      return total!;
    } else {
      return {...quarters, ...innings}.values.fold(0,
          (totalPoints, periodPoints) {
        return totalPoints + (periodPoints ?? 0);
      });
    }
  }

  String getLastActiveQuarter() {
    return quarters.entries
        .lastWhere(
          (quarter) => quarter.value != null,
          orElse: () => const MapEntry('Not Started', null),
        )
        .key;
  }

  String getLastActiveInning() {
    // Get the last inning with a non-null value.
    var lastActiveInning = innings.entries
        .lastWhere(
          (inning) => inning.value != null,
          orElse: () => const MapEntry('Not Started', null),
        )
        .key;
    return lastActiveInning;
  }
}
