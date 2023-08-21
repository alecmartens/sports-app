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
      id: _getIntFromJson(json['id']),
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      logo: json['logo'] ?? '',
      season: _getIntFromJson(json['season']),
    );
  }

  static int _getIntFromJson(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value) ?? 0;
    } else {
      return 0;
    }
  }
}
