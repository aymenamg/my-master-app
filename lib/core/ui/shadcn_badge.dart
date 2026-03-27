import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum ShadcnBadgeVariant {
  defaultVariant,
  secondary,
  destructive,
  outline,
}

class ShadcnBadge extends StatelessWidget {
  final String text;
  final ShadcnBadgeVariant variant;

  const ShadcnBadge({
    Key? key,
    required this.text,
    this.variant = ShadcnBadgeVariant.defaultVariant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color foregroundColor;
    BorderSide borderSide = BorderSide.none;

    switch (variant) {
      case ShadcnBadgeVariant.defaultVariant:
        backgroundColor = AppTheme.primary;
        foregroundColor = AppTheme.primaryForeground;
        break;
      case ShadcnBadgeVariant.secondary:
        backgroundColor = AppTheme.secondary;
        foregroundColor = AppTheme.secondaryForeground;
        break;
      case ShadcnBadgeVariant.destructive:
        backgroundColor = AppTheme.destructive;
        foregroundColor = AppTheme.destructiveForeground;
        break;
      case ShadcnBadgeVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = AppTheme.foreground;
        borderSide = BorderSide(color: AppTheme.border, width: 1);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16), // Badges normally fully rounded in Shadcn
        border: borderSide.style != BorderStyle.none ? Border.all(color: borderSide.color) : null,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: foregroundColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
