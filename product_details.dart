import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  // غيري الرقم ده برقم الواتساب اللي تحبيه بصيغة دولية بدون +
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
          backgroundColor: const Color(0xFF25488E),
          title: const Text('تفاصيل المنتج', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
            tooltip: 'عودة',
          ),
        ),
        backgroundColor: const Color(0xFFF9F9F9),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.image_not_supported,
                      size: 70, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'ساعة ذكية فاخرة - إصدار 2023',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF25488E),
                            borderRadius: BorderRadius.circular(8),
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
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text('(245 مراجعة)', style: TextStyle(color: Colors.grey)),
                        SizedBox(width: 8),
                        Icon(Icons.star, color: Color(0xFFF4C42D)),
                        Icon(Icons.star, color: Color(0xFFF4C42D)),
                        Icon(Icons.star, color: Color(0xFFF4C42D)),
                        Icon(Icons.star_half, color: Color(0xFFF4C42D)),
                        Icon(Icons.star_border, color: Color(0xFFF4C42D)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _infoCard(
                      title: 'الوصف',
                      content:
                      'ساعة ذكية متطورة بشاشة لمس AMOLED مقاس 1.4 بوصة، مقاومة للماء حتى عمق 50 متر، تدعم تتبع النشاط البدني، معدل ضربات القلب، وضغط الدم. بطارية تدوم حتى 7 أيام مع شحن سريع.',
                      icon: Icons.description,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _openWhatsApp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF25D366),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                        ),
                        icon: const Icon(FontAwesomeIcons.whatsapp,
                            color: Colors.white, size: 20),
                        label: const Text(
                          'اتصل عبر واتساب',
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Icon(icon, color: const Color(0xFF25488E)),
            ],
          ),
          const SizedBox(height: 10),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              content,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Color(0xFF555555),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
