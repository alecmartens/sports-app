class MatchTeam {
  final int id;
  final String name;
  final String logo;
  final String? abbreviation; 
  

  MatchTeam({
    required this.id,
    required this.name,
    required this.logo,
    this.abbreviation,
  });

  factory MatchTeam.fromJson(Map<String, dynamic> json) {
    return MatchTeam(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      abbreviation: json['abbreviation'],
    );
  }
}
