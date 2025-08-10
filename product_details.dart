
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<StatefulWidget> {
  String _selectedImage = 'assets/images/product1.png';
  bool isFavorite = false;
  int _selectedColorIndex = 0;
  final List<Color> availableColors = [
    const Color(0xFF25488E),
    const Color(0xFF212121),
    const Color(0xFFF4C42D),
  ];

  void _changeSelectedImage(String imagePath) {
    setState(() {
      _selectedImage = imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'إيجارك',
      theme: ThemeData(
        fontFamily: 'Cairo',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF25488E)),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, size: 28),
              onPressed: () {},
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
                ),
                color: isFavorite ? const Color(0xFFF4C42D) : Colors.black,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // صور المنتج
              Stack(
                children: [
                  Container(
                    height: 350,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4C42D).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Image.asset(_selectedImage, fit: BoxFit.contain),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 30,
                    child: Column(
                      children: [
                        _buildSmallImage('assets/images/product1.png'),
                        const SizedBox(height: 15),
                        _buildSmallImage('assets/images/product2.png'),
                        const SizedBox(height: 15),
                        _buildSmallImage('assets/images/product3.png'),
                      ],
                    ),
                  ),
                ],
              ),

              // اسم المنتج والتقييم
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF25488E).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: const [
                              Text("4.8", style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(width: 3),
                              Icon(Icons.star_rounded, color: Color(0xFFF4C42D), size: 18),
                            ],
                          ),
                        ),
                        const Text(
                          "كاميرا تصوير احترافية",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Color(0xFF25488E),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "كاميرا عالية الجودة مناسبة لتصوير الفعاليات والأفراح والجلسات الخاصة. إمكانية التأجير باليوم أو الأسبوع.",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              // مواصفات المنتج
              _buildModernInfoTile(
                icon: Icons.info_outline_rounded,
                title: "تفاصيل المنتج",
                subtitle: "عرض المواصفات الكاملة للمنتج",
                onTap: () {},
              ),

              // الألوان أو الخيارات
              _buildModernInfoTile(
                icon: Icons.palette_rounded,
                title: "الألوان المتوفرة",
                subtitle: "اختر اللون المناسب لك",
                trailing: SizedBox(
                  width: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    itemCount: availableColors.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColorIndex = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: availableColors[index],
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _selectedColorIndex == index
                                    ? const Color(0xFF25488E)
                                    : Colors.grey.shade300,
                                width: _selectedColorIndex == index ? 2 : 1,
                              ),
                            ),
                            child: _selectedColorIndex == index
                                ? const Icon(Icons.check, color: Colors.white, size: 16)
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // السعر وزر الإيجار
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF25488E),
                        minimumSize: const Size(150, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: const Text(
                        "استأجر الآن",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "السعر اليومي",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: '150',
                                style: TextStyle(
                                  color: Color(0xFF25488E),
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              TextSpan(
                                text: ' ر.س',
                                style: TextStyle(
                                  color: Color(0xFF25488E),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildSmallImage(String imagePath) {
    bool isSelected = _selectedImage == imagePath;
    return GestureDetector(
      onTap: () => _changeSelectedImage(imagePath),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF25488E) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: const Color(0xFF25488E).withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 1,
              ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildModernInfoTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 8),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: const Color(0xFFF4C42D).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF25488E), size: 22),
        ),
        title: Text(
          title,
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF25488E),
          ),
        ),
        subtitle: subtitle != null
            ? Text(
          subtitle,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 13,
          ),
        )
            : null,
        trailing: trailing ??
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Color(0xFF25488E),
            ),
      ),
    );
  }
}