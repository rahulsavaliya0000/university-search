// lib/presentation/widgets/university_list_item.dart

import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:suzuki/core/const/app_assets/app_colors.dart';
import '../../data/models/university.dart';

class UniversityListItem extends StatelessWidget {
  final University uni;
  final VoidCallback onTap;
  final String? searchQuery;

  const UniversityListItem({
    Key? key,
    required this.uni,
    required this.onTap,
    this.searchQuery,
  }) : super(key: key);

  Widget _highlight(BuildContext context, String text) {
    final q = (searchQuery ?? '').toLowerCase();
    final baseStyle = Theme.of(context).textTheme.bodyLarge!;
    if (q.isEmpty || !text.toLowerCase().contains(q)) {
      return Text(text, style: baseStyle);
    }

    final lcText = text.toLowerCase();
    final idx = lcText.indexOf(q);
    final before = text.substring(0, idx);
    final match = text.substring(idx, idx + q.length);
    final after = text.substring(idx + q.length);

    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: [
          TextSpan(text: before),
          TextSpan(
            text: match,
            style: baseStyle.copyWith(
              backgroundColor: AppColors.accent.withOpacity(0.4),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: after),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hint = AppColors.textSecondary;

    return Card(
      borderOnForeground: true,

      surfaceTintColor: AppColors.surface,
      color: AppColors.surface,
      shadowColor: AppColors.primary.withBlue(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            children: [
              // Country flag
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(50),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: CountryFlag.fromCountryCode(
                  uni.alphaTwoCode,
                  height: 32,
                  width: 48,
                ),
              ),

              const SizedBox(width: 16),

              // Text block
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _highlight(context, uni.name),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.public, size: 14, color: AppColors.primary),
                        const SizedBox(width: 4),
                        Expanded(child: _highlight(context, uni.country)),
                      ],
                    ),
                    if (uni.stateProvince?.isNotEmpty ?? false) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              uni.stateProvince!,

                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(color: hint),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 8),
              Icon(Icons.chevron_right, color: AppColors.primary, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
