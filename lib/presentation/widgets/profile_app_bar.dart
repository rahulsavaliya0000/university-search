// lib/presentation/widgets/profile_app_bar.dart

import 'package:flutter/material.dart';
import 'package:suzuki/core/const/app_assets/app_colors.dart';
import 'package:suzuki/core/const/app_assets/app_assets.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: colorScheme.surface,
      leadingWidth: 72,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.primary.withAlpha(90),

          child: ClipOval(
            child: Image.asset(
              Assets.userIcon,
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      titleSpacing: 0,
      toolbarHeight: 80,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, Rahul!',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Search Universities',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_none, color: AppColors.primary),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
