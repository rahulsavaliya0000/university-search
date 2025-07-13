// lib/presentation/views/detail_screen.dart

import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_animate/flutter_animate.dart'; // ← for animations
import 'package:suzuki/core/const/app_assets/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/university.dart';

class DetailScreen extends StatelessWidget {
  final University university;

  const DetailScreen({Key? key, required this.university}) : super(key: key);

  Future<void> _openWebsite(BuildContext context) async {
    final uri = Uri.parse(university.primaryWebPage);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to open ${uri.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // base delay between items
    final step = 150.ms;

    return Scaffold(
      appBar: AppBar(
        title: const Text('University Details'),
        elevation: 1,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          // 1) Avatar
          Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.scaffoldBackground,
                  child: CountryFlag.fromCountryCode(
                    university.alphaTwoCode,
                    height: 48,
                    width: 72,
                  ),
                ),
              )
              .animate(delay: step * 0)
              .fadeIn(duration: 300.ms)
              .slideY(begin: 0.3, duration: 300.ms),

          const SizedBox(height: 24),

          // 2) Name
          Text(
                university.name,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              )
              .animate(delay: step * 1)
              .fadeIn(duration: 300.ms)
              .slideY(begin: 0.3, duration: 300.ms),

          const SizedBox(height: 32),

          // 3) Info Card
          Card(
            color: AppColors.surface,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                // Country row
                _buildInfoRow(
                      context,
                      icon: Icons.public,
                      text: university.country,
                    )
                    .animate(delay: step * 2)
                    .fadeIn(duration: 300.ms)
                    .slideX(begin: -0.2, duration: 300.ms),

                // optional state/province
                if (university.stateProvince?.isNotEmpty ?? false)
                  _buildInfoRow(
                        context,
                        icon: Icons.map,
                        text: university.stateProvince!,
                      )
                      .animate(delay: step * 3)
                      .fadeIn(duration: 300.ms)
                      .slideX(begin: -0.2, duration: 300.ms),

                // domains
                _buildInfoRow(
                      context,
                      icon: Icons.link,
                      text: university.domains.join(', '),
                      title: 'Domain(s)',
                      isSubtitle: true,
                    )
                    .animate(delay: step * 4)
                    .fadeIn(duration: 300.ms)
                    .slideX(begin: -0.2, duration: 300.ms),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // 4) Visit Website button
          SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () => _openWebsite(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary, width: 2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Visit Website',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
              .animate(delay: step * 5)
              .fadeIn(duration: 300.ms)
              .slideY(begin: 0.3, duration: 300.ms),

          // 5) Poweres by...
          const SizedBox(height: 24),
          Text(
            'Powered by University API',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ).animate(delay: step * 6).fadeIn(duration: 300.ms),
        ],
      ),
    );
  }

  /// Helper to build a bordered ListTile
  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String text,
    String? title,
    bool isSubtitle = false,
  }) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary, width: 2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title ?? text, style: theme.textTheme.bodyLarge),
        subtitle: isSubtitle
            ? Text(text, style: theme.textTheme.bodyMedium)
            : null,
      ),
    );
  }
}
