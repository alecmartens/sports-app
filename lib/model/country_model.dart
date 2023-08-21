class Country {
  final int id;
  final String name;
  final String code;
  final String flag;

  Country({
    required this.id,
    required this.name,
    required this.code,
    required this.flag,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: _getIdFromJson(json['id']),
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      flag: json['flag'] ?? '',
    );
  }

  static int _getIdFromJson(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value) ?? 0;
    } else {
      return 0;
    }
  }
}
