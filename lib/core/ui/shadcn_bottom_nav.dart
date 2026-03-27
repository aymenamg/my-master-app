import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class ShadcnBottomNav extends StatelessWidget {
  final int currentIndex;
  final VoidCallback? onCenterTap;

  const ShadcnBottomNav({
    Key? key, 
    required this.currentIndex,
    this.onCenterTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 32,
      left: 24,
      right: 24,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                height: 72,
                decoration: BoxDecoration(
                  color: AppTheme.background.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: AppTheme.border.withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    )
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(context, icon: Icons.shopping_cart_outlined, index: 0, route: '/total'),
                    const SizedBox(width: 48), // Space for glowing center button
                    _buildNavItem(context, icon: Icons.account_balance_wallet_outlined, index: 1, route: '/budget'),
                  ],
                ),
              ),
            ),
          ),
          if (onCenterTap != null)
            Positioned(
              top: -24,
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  onCenterTap!();
                },
                child: Container(
                  height: 64, width: 64,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppTheme.primary, AppTheme.primary.withOpacity(0.8)],
                      begin: Alignment.topLeft, end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primary.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      )
                    ]
                  ),
                  child: const Icon(Icons.qr_code_scanner_rounded, color: Colors.white, size: 28),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, {required IconData icon, required int index, required String route}) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          HapticFeedback.lightImpact();
          context.go(route);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Icon(
          icon,
          color: isSelected ? AppTheme.primary : AppTheme.mutedForeground,
          size: 26,
        ),
      ),
    );
  }
}
