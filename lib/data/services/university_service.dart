// lib/services/university_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/university.dart';

class UniversityService {
  // NOTE: HTTP, not HTTPS
  static const _host = 'universities.hipolabs.com';
  final http.Client _client;

  UniversityService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<University>> search({
    String? name,
    String? country,
    int? limit,
    int? offset,
  }) async {
    final query = <String, String>{};
    if (name != null && name.isNotEmpty) query['name'] = name;
    if (country != null && country.isNotEmpty) query['country'] = country;
    if (limit != null) query['limit'] = '$limit';
    if (offset != null) query['offset'] = '$offset';

    // Use HTTP here:
    final uri = Uri.http(_host, '/search', query);

    try {
      debugPrint('📤 Requesting: $uri');
      final res = await _client.get(uri);
      debugPrint('📥 Response: ${res.statusCode} ${res.body}');
      if (res.statusCode != 200) {
        throw Exception('API Error: ${res.statusCode} ${res.reasonPhrase}');
      }
      final List jsonList = json.decode(res.body) as List;
      return jsonList
          .map((e) => University.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e, st) {
      debugPrint('❌ Error fetching universities:\n$e\n$st');
      rethrow;
    }
  }
}
