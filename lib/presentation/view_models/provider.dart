// lib/providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suzuki/data/models/university.dart';
import 'package:suzuki/data/services/university_service.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

/// Fetch all universities once
final allUniversitiesProvider = FutureProvider<List<University>>((ref) {
  return UniversityService().search();
});

/// Filter by country OR name (startsWith) whenever the query changes
final universityListProvider = Provider<AsyncValue<List<University>>>((ref) {
  final allAsync = ref.watch(allUniversitiesProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();

  return allAsync.when(
    data: (all) {
      if (query.isEmpty) return AsyncValue.data(all);

      final filtered = all.where((u) {
        final country = u.country.toLowerCase();
        final name = u.name.toLowerCase();
        return country.startsWith(query) || name.startsWith(query);
      }).toList();

      return AsyncValue.data(filtered);
    },
    loading: () => const AsyncValue.loading(),
    error: (err, st) => AsyncValue.error(err, st),
  );
});
