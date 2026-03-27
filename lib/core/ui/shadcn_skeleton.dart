import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class ShadcnSkeleton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShadcnSkeleton({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = AppTheme.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.muted,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ).animate(onPlay: (controller) => controller.repeat())
     .shimmer(duration: 1200.ms, color: AppTheme.background.withOpacity(0.5));
  }
}
