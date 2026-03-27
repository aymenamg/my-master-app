import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'socialmedia.dart';
import 'core/theme/app_theme.dart';
import 'core/ui/shadcn_card.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('جهات الاتصال والوسائط'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            ShadcnCard(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppTheme.secondary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.border),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'images/5.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.business_rounded, 
                          size: 32, 
                          color: AppTheme.foreground,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'اسم المجلة',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'تجدنا على شبكاتنا',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            Column(
              children: [
                SocialMediaButton(
                  url: 'http://cs.univ-batna2.dz/',
                  label: 'الموقع الإلكتروني',
                  icon: FontAwesomeIcons.globe,
                  color: AppTheme.foreground,
                ),
                SocialMediaButton(
                  url: 'https://instagram.com/',
                  label: 'Instagram',
                  icon: FontAwesomeIcons.instagram,
                  color: Color(0xFFE1306C),
                ),
                SocialMediaButton(
                  url: 'https://www.facebook.com/chefdepartementinformatiquebatna',
                  label: 'Facebook',
                  icon: FontAwesomeIcons.facebookF,
                  color: Color(0xFF1877F2),
                ),
                SocialMediaButton(
                  url: 'https://wa.me/',
                  label: 'WhatsApp',
                  icon: FontAwesomeIcons.whatsapp,
                  color: Color(0xFF25D366),
                ),
                SocialMediaButton(
                  url: 'https://www.google.com/maps/place/Université+Batna+2/@35.6357032,6.2753977,16.06z/',
                  label: 'الموقع',
                  icon: FontAwesomeIcons.locationDot,
                  color: Color(0xFFEA4335),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
