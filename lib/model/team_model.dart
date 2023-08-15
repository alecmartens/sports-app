class Team {
  final String name;
  final String logo;

  Team({
    required this.name,
    required this.logo,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      name: json['name'],
      logo: json['logo'],
    );
  }
}
