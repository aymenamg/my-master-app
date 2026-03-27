import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'core/theme/app_theme.dart';

class SocialMediaButton extends StatelessWidget {
  final String url;
  final IconData icon;
  final String label;
  final Color color;

  const SocialMediaButton({
    super.key,
    required this.url,
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: AppTheme.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppTheme.border),
          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
          onTap: () async {
            final uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: FaIcon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    label,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.foreground,
                      ),
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: AppTheme.mutedForeground),
              ],
            ),
          ),
        ),
      ),
    );
  }
}