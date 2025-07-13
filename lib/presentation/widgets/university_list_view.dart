// lib/presentation/widgets/university_list_view.dart

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:suzuki/core/const/app_assets/app_colors.dart';
import 'package:suzuki/presentation/widgets/university_list_item.dart.dart';
import '../view_models/provider.dart';

class UniversityListView extends ConsumerStatefulWidget {
  const UniversityListView({Key? key}) : super(key: key);

  @override
  ConsumerState<UniversityListView> createState() => _UniversityListViewState();
}

class _UniversityListViewState extends ConsumerState<UniversityListView> {
  final _scrollController = ScrollController();
  int _displayCount = 20;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final query = ref.read(searchQueryProvider);
    final all = ref.read(universityListProvider).asData?.value;
    if (query.isEmpty &&
        all != null &&
        _displayCount < all.length &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      setState(() {
        _displayCount = min(_displayCount + 20, all.length);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);
    final uniAsync = ref.watch(universityListProvider);

    return uniAsync.when(
      loading: () => const Center(
        child: CupertinoActivityIndicator(color: AppColors.surface),
      ),
      error: (err, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 16),
            Text('Error: $err'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                ref.read(searchQueryProvider.notifier).state = query;
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (allUnis) {
        final totalCount = allUnis.length;
        final displayList = query.isEmpty
            ? allUnis.take(_displayCount).toList()
            : allUnis;

        if (displayList.isEmpty && query.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 48, color: AppColors.hint),
                const SizedBox(height: 16),
                Text('No universities found for "$query"'),
                const SizedBox(height: 8),
                const Text(
                  'Try a different search term',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          );
        }
        if (displayList.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.school_outlined, size: 64, color: AppColors.hint),
                SizedBox(height: 16),
                Text(
                  'No universities loaded',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Check your internet connection',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                query.isEmpty
                    ? 'Showing $totalCount universities'
                    : 'Found $totalCount universities',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: displayList.length,
                itemBuilder: (ctx, idx) {
                  final uni = displayList[idx];
                  // Wrap each item in a staggered fade+slide animation:
                  return UniversityListItem(
                        uni: uni,
                        onTap: () {
                          GoRouter.of(context).pushNamed('detail', extra: uni);
                        },
                        searchQuery: query.isEmpty ? null : query,
                      )
                      .animate(delay: 100.ms * idx) // stagger by index
                      .fadeIn(duration: 300.ms) // fade in
                      .slideY(begin: 0.2, duration: 300.ms); // slide up
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
