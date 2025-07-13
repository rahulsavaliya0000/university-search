// lib/presentation/views/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suzuki/core/const/app_assets/app_colors.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/university_search_field.dart';
import '../widgets/university_list_view.dart';
import '../view_models/provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onQueryChanged(String value) {
    // Reset pagination
    ref.read(searchQueryProvider.notifier).state = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary.withValues(alpha: 0.5),
      appBar: const ProfileAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            UniversitySearchField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: _onQueryChanged,
            ),
            const SizedBox(height: 12),
            const Expanded(child: UniversityListView()),
          ],
        ),
      ),
    );
  }
}
