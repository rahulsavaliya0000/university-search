// lib/presentation/widgets/university_search_field.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart'; // ← added
import 'package:suzuki/core/const/app_assets/app_colors.dart';
import '../view_models/provider.dart';
import '../../core/const/app_assets/app_assets.dart';

class UniversitySearchField extends ConsumerWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String) onChanged;

  const UniversitySearchField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primary.withAlpha(200),
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            fillColor: AppColors.surface,
            hintText: 'Search by country or name',
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(Assets.searchicon, width: 24, height: 24),
            ),
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.clear();
                      onChanged('');
                    },
                  )
                : null,
          ),
          onChanged: onChanged,
          textInputAction: TextInputAction.search,
        )
        .animate() // ← start animation chain
        .fadeIn(duration: 400.ms) // ← fade in over 400ms
        .slideY(begin: 0.2, duration: 400.ms); // ← slide up from below
  }
}
