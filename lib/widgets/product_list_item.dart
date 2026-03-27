import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../core/theme/app_theme.dart';
import '../core/ui/shadcn_button.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductListItem extends StatelessWidget {
  final Map<String, dynamic> product;
  final int index;

  const ProductListItem({
    Key? key,
    required this.product,
    required this.index,
  }) : super(key: key);

  Widget _buildCategoryIcon(String? category) {
    IconData iconData;
    Color iconColor;

    switch (category) {
      case 'إلكترونيات':
      case 'electronics':
        iconData = FontAwesomeIcons.mobileScreen;
        iconColor = Colors.blue;
        break;
      case 'مشروبات':
      case 'drinks':
        iconData = FontAwesomeIcons.bottleWater;
        iconColor = Colors.teal;
        break;
      case 'مواد غذائية':
      case 'food':
        iconData = FontAwesomeIcons.basketShopping;
        iconColor = Colors.orange;
        break;
      case 'ألبان':
      case 'dairy':
        iconData = FontAwesomeIcons.cow;
        iconColor = Colors.indigo;
        break;
      default:
        iconData = FontAwesomeIcons.boxOpen;
        iconColor = AppTheme.mutedForeground;
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: iconColor.withOpacity(0.2)),
      ),
      child: Center(
        child: FaIcon(iconData, color: iconColor, size: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: [
            _buildCategoryIcon(product['category']),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${product['price']} DA',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.foreground,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            
            // Quantity Controls (Shadcn Outline Style)
            Container(
              height: 36,
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.border, width: 1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => cart.decreaseQuantity(index),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Icon(Icons.remove, size: 16, color: AppTheme.foreground),
                    ),
                  ),
                  Container(
                    width: 1,
                    color: AppTheme.border,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      '${product['quantity'] ?? 1}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  Container(
                    width: 1,
                    color: AppTheme.border,
                  ),
                  InkWell(
                    onTap: () => cart.increaseQuantity(index),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Icon(Icons.add, size: 16, color: AppTheme.foreground),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            
            // Delete Button
            ShadcnButton(
              size: ShadcnButtonSize.icon,
              variant: ShadcnButtonVariant.ghost,
              icon: Icons.delete_outline_rounded,
              onPressed: () => cart.removeProduct(index),
            ),
          ],
        ),
      ),
    ).animate(key: ValueKey(product['id'] ?? product['name'] ?? index))
     .fade(duration: 400.ms, curve: Curves.easeOut)
     .slideY(begin: 0.15, end: 0, curve: Curves.easeOutQuart)
     .scaleXY(begin: 0.95, end: 1.0);
  }
}
