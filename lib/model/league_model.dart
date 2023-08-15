class League {
  final int id;
  final String name;
  final String type;
  final String logo;
  final int season;

  League({
    required this.id,
    required this.name,
    required this.type,
    required this.logo,
    required this.season,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      logo: json['logo'] ?? '',
      season: json['season'] ?? 0,
    );
  }
}
