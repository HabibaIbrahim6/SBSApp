import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  final String whatsappNumber = '01156102316';

  Future<void> _openWhatsApp() async {
    final Uri whatsappUrl = Uri.parse('https://wa.me/$whatsappNumber');
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('لا يمكن فتح واتساب');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 8),
              Text(
                'تفاصيل المنتج',
                style: GoogleFonts.tajawal(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          backgroundColor: Color(0xFF25488E),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF9F9F9),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Product Image Section
              Container(
                height: 280,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(Icons.image_not_supported,
                          size: 80, color: Colors.grey[400]),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 15,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.photo_library, color: Colors.white, size: 16),
                            SizedBox(width: 5),
                            Text('4 صور', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Product Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title and Price Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'ساعة ذكية فاخرة - إصدار 2023',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                              height: 1.3,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF25488E),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: const Text(
                            '1,250 ج.م',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Rating Row
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text('(245 مراجعة)',
                              style: TextStyle(color: Colors.grey, fontSize: 13)),
                        ),
                        const SizedBox(width: 8),
                        ...List.generate(5, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Icon(
                              index < 3
                                  ? Icons.star
                                  : index == 3
                                  ? Icons.star_half
                                  : Icons.star_border,
                              color: const Color(0xFFF4C42D),
                              size: 20,
                            ),
                          );
                        }),
                      ],
                    ),

                    // Divider
                    const SizedBox(height: 20),
                    Divider(color: Colors.grey[300], height: 1),
                    const SizedBox(height: 20),

                    // Description Card
                    _infoCard(
                      title: 'الوصف',
                      content:
                      'ساعة ذكية متطورة بشاشة لمس AMOLED مقاس 1.4 بوصة، مقاومة للماء حتى عمق 50 متر، تدعم تتبع النشاط البدني، معدل ضربات القلب، وضغط الدم. بطارية تدوم حتى 7 أيام مع شحن سريع.',
                      icon: Icons.description,
                    ),

                    // Features Card
                    const SizedBox(height: 15),
                    // _infoCard(
                    //   title: 'المواصفات',
                    //   content:
                    //   '• شاشة AMOLED 1.4 بوصة\n• مقاومة للماء حتى 50 متر\n• تتبع النشاط البدني والصحي\n• بطارية تدوم 7 أيام\n• شحن سريع\n• متوافق مع iOS و Android',
                    //   icon: Icons.list_alt,
                    // ),

                    // WhatsApp Button
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: _openWhatsApp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF25D366),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          shadowColor: const Color(0xFF25D366).withOpacity(0.3),
                        ),
                        icon: const Icon(FontAwesomeIcons.whatsapp,
                            color: Colors.white, size: 24),
                        label: const Text(
                          'اتصل عبر واتساب',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.rtl,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF25488E),
                ),
              ),
              Icon(icon, color: const Color(0xFF25488E), size: 22),
            ],
          ),
          const SizedBox(height: 12),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              content,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 15,
                height: 1.6,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
