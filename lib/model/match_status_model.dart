class MatchStatus {
  final String long;
  final String short;

  MatchStatus({required this.long, required this.short});

  factory MatchStatus.fromJson(Map<String, dynamic> json) {
    return MatchStatus(
      long: json['long'] as String,
      short: json['short'] as String,
    );
  }
}