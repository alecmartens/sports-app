class Scores {
  final TeamScore home;
  final TeamScore away;

  Scores({required this.home, required this.away});

  factory Scores.fromJson(Map<String, dynamic> json) {
    return Scores(
      home: TeamScore.fromJson(json['home']),
      away: TeamScore.fromJson(json['away']),
    );
  }
}

class TeamScore {
  final int? total;
  final Map<String, int?> innings;

  TeamScore({required this.total, required this.innings});

  factory TeamScore.fromJson(Map<String, dynamic> json) {
    return TeamScore(
      total: json['total'],
      innings: Map<String, int?>.from(json['innings']),
    );
  }
}
