class MatchTeam {
  final int id;
  final String name;
  final String logo;

  MatchTeam({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory MatchTeam.fromJson(Map<String, dynamic> json) {
    return MatchTeam(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
    );
  }
}
