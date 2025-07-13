// lib/models/university.dart

class University {
  final String name;
  final String country;
  final List<String> domains;
  final List<String> webPages;
  final String? stateProvince;
  final String alphaTwoCode;

  University({
    required this.name,
    required this.country,
    required this.domains,
    required this.webPages,
    required this.alphaTwoCode,
    this.stateProvince,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'] as String,
      country: json['country'] as String,
      domains: List<String>.from(json['domains'] as List<dynamic>),
      webPages: List<String>.from(json['web_pages'] as List<dynamic>),
      stateProvince: json['state-province'] as String?, // null OK
      alphaTwoCode: json['alpha_two_code'] as String,
    );
  }

  /// Convenient getter for “primary” domain/website
  String get primaryDomain => domains.isNotEmpty ? domains.first : '';
  String get primaryWebPage => webPages.isNotEmpty ? webPages.first : '';
}
