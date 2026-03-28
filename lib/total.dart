import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';
import 'providers/cart_provider.dart';
import 'widgets/product_list_item.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'core/theme/app_theme.dart';
import 'core/ui/shadcn_button.dart';
import 'core/ui/shadcn_card.dart';
import 'core/ui/shadcn_badge.dart';
import 'core/ui/shadcn_bottom_nav.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

class Total extends StatefulWidget {
  const Total({Key? key}) : super(key: key);

  @override
  State<Total> createState() => TotalState();
}

class TotalState extends State<Total> {
  bool _hasShownWarning = false;
  final String colorCode = "#09090B"; // AppTheme.foreground
  final String cancelButtonText = "إلغاء";
  final bool isShowFlashIcon = false;

  void showBudgetWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: AlertDialog(
            backgroundColor: AppTheme.background.withOpacity(0.95),
            elevation: 0,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            side: BorderSide(color: AppTheme.border),
          ),
          title: Row(
            children: [
              Icon(Icons.warning_rounded, color: AppTheme.destructive, size: 24),
              const SizedBox(width: 12),
              Text('تنبيه الميزانية', style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          content: Text(
            'تجاوز السعر الإجمالي ميزانيتك المخصصة.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            ShadcnButton(
              onPressed: () => context.pop(),
              text: 'حسناً',
              variant: ShadcnButtonVariant.defaultVariant,
            ),
          ],
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    if (!_hasShownWarning && cart.isBudgetExceeded) {
      _hasShownWarning = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showBudgetWarning();
      });
    } else if (_hasShownWarning && !cart.isBudgetExceeded) {
      _hasShownWarning = false;
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('سلة المشتريات'),
        leading: IconButton(
          icon: ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (_, mode, __) {
              return Icon(mode == ThemeMode.light ? Icons.dark_mode_rounded : Icons.light_mode_rounded, size: 20);
            },
          ),
          onPressed: () {
            final newMode = themeNotifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
            AppTheme.applyTheme(newMode);
            themeNotifier.value = newMode;
          },
        ),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert_rounded),
            color: AppTheme.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              side: BorderSide(color: AppTheme.border),
            ),
            onSelected: (item) {
              if (item == 0) context.push('/budget');
              if (item == 1) {
                Provider.of<CartProvider>(context, listen: false).clearProducts();
              }
              if (item == 2) context.push('/about');
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Icon(Icons.account_balance_wallet_outlined, size: 18, color: AppTheme.foreground),
                    const SizedBox(width: 12),
                    Text('تعديل الميزانية', style: Theme.of(context).textTheme.labelLarge),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.remove_shopping_cart_outlined, size: 18, color: AppTheme.destructive),
                    const SizedBox(width: 12),
                    Text('إفراغ السلة', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppTheme.destructive)),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.info_outline_rounded, size: 18, color: AppTheme.foreground),
                    const SizedBox(width: 12),
                    Text('حول التطبيق', style: Theme.of(context).textTheme.labelLarge),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
          // Total Top Summary
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: cart.isBudgetExceeded 
                      ? [AppTheme.destructive, AppTheme.destructive.withOpacity(0.7)]
                      : [AppTheme.primary, AppTheme.primary.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: cart.isBudgetExceeded 
                        ? AppTheme.destructive.withOpacity(0.3) 
                        : AppTheme.primary.withOpacity(0.3),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  )
                ]
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'المجموع التقديري',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${cart.totalPrice} د.ج',
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      cart.isBudgetExceeded ? Icons.warning_amber_rounded : Icons.check_circle_outline_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // List Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Row(
              children: [
                Text(
                  'العناصر الممسوحة',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                ShadcnBadge(
                  text: '${cart.productList.length} عناصر',
                  variant: ShadcnBadgeVariant.secondary,
                ),
              ],
            ),
          ),

          // List
          Expanded(
            child: cart.productList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/animations/empty_cart.json',
                          width: 250,
                          height: 250,
                          errorBuilder: (context, error, stackTrace) => Icon(Icons.shopping_cart_outlined, size: 80, color: AppTheme.mutedForeground.withOpacity(0.5)),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'سلة مشترياتك فارغة',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppTheme.mutedForeground),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'امسح الرمز الشريطي للبدء',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 100, top: 8),
                    itemCount: cart.productList.length,
                    itemBuilder: (context, index) {
                      return ProductListItem(
                        product: cart.productList[index],
                        index: index,
                      );
                    },
                  ),
          ),
          
          // Checkout Button
          if (cart.productList.isNotEmpty)
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 90),
              decoration: BoxDecoration(
                color: AppTheme.background,
                border: Border(top: BorderSide(color: AppTheme.border)),
              ),
              child: ShadcnButton(
                isFullWidth: true,
                size: ShadcnButtonSize.lg,
                onPressed: () {
                  showFastCheckoutDialog(context);
                },
                text: 'التقدم لإتمام الطلب',
              ),
            ),
        ],
      ),
    ),
    ShadcnBottomNav(
      currentIndex: 0,
      onCenterTap: scanBarcode,
    ),
  ],
),
);
}

  void showFastCheckoutDialog(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final payloadItems = cart.productList.map((p) => '${p['name']}:${p['quantity'] ?? 1}').join(',');
    final qrData = 'CHK:$payloadItems';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
          child: AlertDialog(
            backgroundColor: AppTheme.background.withOpacity(0.95),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              side: BorderSide(color: AppTheme.border.withOpacity(0.5)),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: QrImageView(
                      data: qrData,
                      version: QrVersions.auto,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'أظهر هذا الرمز لأمين الصندوق',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'سيتم نقل جميع مشترياتك في ثانية واحدة للقائم على الصندوق',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.mutedForeground,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ShadcnButton(
                  isFullWidth: true,
                  variant: ShadcnButtonVariant.outline,
                  onPressed: () => Navigator.of(context).pop(),
                  text: 'إغلاق',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.card,
                borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                border: Border.all(color: AppTheme.border),
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 120, width: double.infinity, decoration: BoxDecoration(color: Colors.teal.shade200, borderRadius: BorderRadius.circular(16))),
                    const SizedBox(height: 24),
                    Container(height: 24, width: 140, color: Colors.white),
                    const SizedBox(height: 12),
                    Container(height: 16, width: double.infinity, color: Colors.white),
                    const SizedBox(height: 8),
                    Container(height: 16, width: 200, color: Colors.white),
                    const SizedBox(height: 32),
                    Container(height: 48, width: double.infinity, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12))),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> scanBarcode() async {
    try {
      if (kIsWeb) {
        // MOCK BARCODE FOR WEB TESTING
        final String mockWebBarcode = "036000291452";
        _showLoadingDialog(context);
        
        final productSnapshot = await FirebaseFirestore.instance
            .collection('products')
            .doc(mockWebBarcode)
            .get();

        if (!mounted) return;
        Navigator.of(context).pop();

        if (productSnapshot.exists) {
          final productData = productSnapshot.data() as Map<String, dynamic>;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return _buildDetailedProductDialog(context, {
                'name': productData['name'] ?? 'منتج غير معروف',
                'price': double.tryParse(productData['price'].toString()) ?? 0.0,
                'description': productData['description'] ?? 'لا يوجد وصف',
                'category': productData['category'] ?? 'عام',
                'brand': productData['brand'] ?? '-',
                'weight': productData['weight'] ?? '-',
                'barcode': mockWebBarcode,
              });
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return _buildErrorDialog(
                  context, 'غير موجود', 'تم محاكاة مسح الباركود $mockWebBarcode ولكنه غير موجود في قاعدة بيانات Firebase.');
            },
          );
        }
        return;
      }

      final scanResult = await BarcodeScanner.scan(
        options: const ScanOptions(
          android: AndroidOptions(useAutoFocus: true),
        ),
      );

      final barcode = scanResult.rawContent;
      if (barcode.isEmpty || scanResult.type == ResultType.Cancelled) return; // Cancelled

      _showLoadingDialog(context);

      final productSnapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(barcode)
          .get();

      if (!mounted) return;
      Navigator.of(context).pop();

      if (productSnapshot.exists) {
        final productData = productSnapshot.data();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return _buildDetailedProductDialog(context, productData ?? {});
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return _buildErrorDialog(context, 'غير موجود', 'الرمز الشريطي غير موجود في قاعدة البيانات.');
          },
        );
      }
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return _buildErrorDialog(context, 'خطأ تقني', 'فشلت قراءة الكاميرا.');
        },
      );
    }
  }

  Widget _buildDetailedProductDialog(BuildContext context, Map<String, dynamic> data) {
    final productName = data['name'] ?? 'منتج غير معروف';
    final productPrice = data['price'] ?? 0.0;
    final description = data['description'] ?? 'لا يوجد وصف متاح.';
    final category = data['category'] ?? 'متفرقات';
    final brand = data['brand'] ?? 'غير معروف';
    final weight = data['weight'];
    
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Dialog(
        backgroundColor: AppTheme.background.withOpacity(0.95),
        elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        side: BorderSide(color: AppTheme.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Details Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.secondary,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$productPrice د.ج',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppTheme.foreground),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow('الفئة', category, context),
                  const SizedBox(height: 8),
                  _buildDetailRow('العلامة التجارية', brand, context),
                  if (weight != null) ...[
                    const SizedBox(height: 8),
                    _buildDetailRow('الوزن', weight, context),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1, color: AppTheme.border),
                  ),
                  Text('الوصف', style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 4),
                  Text(description, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ShadcnButton(
                    onPressed: () => context.pop(),
                    variant: ShadcnButtonVariant.outline,
                    text: 'إلغاء',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ShadcnButton(
                    onPressed: () async {
                      HapticFeedback.lightImpact();
                      context.pop();
                      Provider.of<CartProvider>(context, listen: false).addProduct({
                        'name': productName,
                        'price': productPrice,
                      });
                      await Future.delayed(const Duration(milliseconds: 150));
                      HapticFeedback.heavyImpact();
                    },
                    text: 'أضف للسلة',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildDetailRow(String label, String value, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(value, style: Theme.of(context).textTheme.labelLarge),
      ],
    );
  }

  Widget _buildErrorDialog(BuildContext context, String title, String message) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Dialog(
        backgroundColor: AppTheme.background.withOpacity(0.95),
        elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        side: BorderSide(color: AppTheme.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.error_outline_rounded, color: AppTheme.destructive, size: 24),
                const SizedBox(width: 12),
                Text(title, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 16),
            Text(message, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 24),
            ShadcnButton(
              onPressed: () => context.pop(),
              text: 'حسناً',
              isFullWidth: true,
            ),
          ],
        ),
      ),
    ));
  }
}