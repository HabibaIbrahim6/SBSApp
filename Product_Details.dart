import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String _selectedImage = 'assets/images/01.png';
  bool isFavorite = false;
  bool isLoggedIn = false;

  final List<Color> availableColors = [
    const Color(0xFFF4C42D),
    const Color(0xFF25488E),
    const Color(0xFF212121),
  ];
  int _selectedColorIndex = 0;

  Future<void> _shareToWhatsApp() async {
    const String msg = 'أريد تأجير هذا المنتج - آيفون 15 برو ماكس';
    const String url = 'https://example.com/product'; // Add a URL if needed

    try {
      final response = await FlutterShareMe().shareToWhatsApp(
        msg: msg,
        // phoneNumber parameter is not available in current version, use baseUrl instead

      );
      debugPrint(response);
    } catch (e) {
      debugPrint('Error sharing to WhatsApp: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل في مشاركة المنتج عبر واتساب')),
        );
      }
    }
  }

  void _handleRentButton() {
    if (!isLoggedIn) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('تسجيل الدخول مطلوب'),
          content: const Text('يجب تسجيل الدخول أولاً لتتمكن من تأجير المنتج'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate to login page
                // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: const Text('تسجيل الدخول'),
            ),
          ],
        ),
      );
    } else {
      _shareToWhatsApp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, size: 28),
            onPressed: () => Navigator.pop(context),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                size: 28,
                color: isFavorite ? const Color(0xFFF4C42D) : Colors.black, // Moved color here
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                // Removed color parameter from style as it's now on the Icon
              ),
            ),
          ),
        ],
      ),
      // ... rest of the build method remains the same ...
    );
  }
}