import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'providers/cart_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/ui/shadcn_button.dart';
import 'core/ui/shadcn_input.dart';
import 'core/ui/shadcn_card.dart';

class TonBudget extends StatefulWidget {
  const TonBudget({Key? key}) : super(key: key);

  @override
  State<TonBudget> createState() => _TonBudgetState();
}

class _TonBudgetState extends State<TonBudget> {
  final TextEditingController _priceController = TextEditingController();
  
  void _submitBudget(double budget) {
    Provider.of<CartProvider>(context, listen: false).setBudget(budget);
    context.push('/total');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: Navigator.canPop(context) 
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                onPressed: () => context.pop(),
              )
            : null,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 32,
                  color: AppTheme.foreground,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'حدد ميزانيتك',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'أدخل الحد الأقصى للمبلغ الذي ترغب في إنفاقه.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              
              ShadcnCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المبلغ بالدينار (د.ج)',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 12),
                    ShadcnInput(
                      controller: _priceController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      hintText: '0',
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 48),
              
              ShadcnButton(
                isFullWidth: true,
                onPressed: () {
                  final double budget = double.tryParse(_priceController.text) ?? 0.0;
                  if (budget > 0) {
                    _submitBudget(budget);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('الرجاء إدخال مبلغ صحيح', style: TextStyle(color: AppTheme.destructiveForeground)),
                        backgroundColor: AppTheme.destructive,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                text: 'تأكيد الميزانية',
              ),
              const SizedBox(height: 16),
              ShadcnButton(
                isFullWidth: true,
                variant: ShadcnButtonVariant.ghost,
                onPressed: () => _submitBudget(double.infinity),
                text: 'تخطي هذه الخطوة',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
