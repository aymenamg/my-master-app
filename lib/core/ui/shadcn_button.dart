import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

enum ShadcnButtonVariant {
  defaultVariant,
  destructive,
  outline,
  secondary,
  ghost,
  link,
}

enum ShadcnButtonSize {
  defaultSize,
  sm,
  lg,
  icon,
}

class ShadcnButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final String? text;
  final IconData? icon;
  final ShadcnButtonVariant variant;
  final ShadcnButtonSize size;
  final bool isFullWidth;

  const ShadcnButton({
    Key? key,
    required this.onPressed,
    this.child,
    this.text,
    this.icon,
    this.variant = ShadcnButtonVariant.defaultVariant,
    this.size = ShadcnButtonSize.defaultSize,
    this.isFullWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine colors based on variant
    Color backgroundColor;
    Color foregroundColor;
    BorderSide borderSide = BorderSide.none;

    switch (variant) {
      case ShadcnButtonVariant.defaultVariant:
        backgroundColor = AppTheme.primary;
        foregroundColor = AppTheme.primaryForeground;
        break;
      case ShadcnButtonVariant.destructive:
        backgroundColor = AppTheme.destructive;
        foregroundColor = AppTheme.destructiveForeground;
        break;
      case ShadcnButtonVariant.outline:
        backgroundColor = AppTheme.background;
        foregroundColor = AppTheme.foreground;
        borderSide = BorderSide(color: AppTheme.border, width: 1);
        break;
      case ShadcnButtonVariant.secondary:
        backgroundColor = AppTheme.secondary;
        foregroundColor = AppTheme.secondaryForeground;
        break;
      case ShadcnButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = AppTheme.foreground;
        break;
      case ShadcnButtonVariant.link:
        backgroundColor = Colors.transparent;
        foregroundColor = AppTheme.foreground;
        break;
    }

    if (onPressed == null) {
      backgroundColor = backgroundColor.withOpacity(0.5);
      foregroundColor = foregroundColor.withOpacity(0.5);
    }

    // Determine padding and sizing based on size
    EdgeInsetsGeometry padding;
    double? minHeight;
    double? minWidth;

    switch (size) {
      case ShadcnButtonSize.defaultSize:
        padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16);
        minHeight = 40;
        break;
      case ShadcnButtonSize.sm:
        padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12);
        minHeight = 36;
        break;
      case ShadcnButtonSize.lg:
        padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 32);
        minHeight = 44;
        break;
      case ShadcnButtonSize.icon:
        padding = EdgeInsets.zero;
        minHeight = 40;
        minWidth = 40;
        break;
    }

    Widget innerChild = child ??
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: size == ShadcnButtonSize.icon ? 20 : 16, color: foregroundColor),
              if (text != null && size != ShadcnButtonSize.icon) const SizedBox(width: 8),
            ],
            if (text != null && size != ShadcnButtonSize.icon)
              Text(
                text!,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: foregroundColor,
                      decoration: variant == ShadcnButtonVariant.link ? TextDecoration.underline : null,
                    ),
              ),
          ],
        );

    Widget buttonWidget = variant == ShadcnButtonVariant.ghost || variant == ShadcnButtonVariant.link
        ? TextButton(
            onPressed: onPressed != null ? () {
              HapticFeedback.lightImpact();
              onPressed!();
            } : null,
            style: TextButton.styleFrom(
              foregroundColor: foregroundColor,
              padding: padding,
              minimumSize: Size(minWidth ?? 0, minHeight),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
            ),
            child: innerChild,
          )
        : ElevatedButton(
            onPressed: onPressed != null ? () {
              HapticFeedback.lightImpact();
              onPressed!();
            } : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              elevation: variant == ShadcnButtonVariant.defaultVariant ? 8 : 0,
              padding: padding,
              minimumSize: Size(minWidth ?? 0, minHeight),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                side: borderSide,
              ),
              shadowColor: variant == ShadcnButtonVariant.defaultVariant 
                  ? backgroundColor.withOpacity(0.4) 
                  : Colors.transparent,
            ),
            child: innerChild,
          );

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: buttonWidget);
    }

    return buttonWidget;
  }
}
