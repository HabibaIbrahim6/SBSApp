import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'MainPage.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _logoSlideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    // تكبير التدرجي للشعار مع تأثير مرن
    _scaleAnimation = Tween<double>(begin: 0.2, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.7, curve: Curves.elasticOut),
      ),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // بعد اكتمال التكبير، نعود للحجم الطبيعي
        _controller.animateTo(0.8, duration: Duration(milliseconds: 500));
      }
    });

    // دوران الشعار عند الدخول
    _rotationAnimation = Tween<double>(begin: -0.5, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    // تدرج الظهور
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 1.0, curve: Curves.easeIn),
      ),
    );

    // حركة انزلاق للنص
    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );

    // حركة انزلاق للشعار من الجانب
    _logoSlideAnimation = Tween<Offset>(
      begin: Offset(-2.0, 0.0), 
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _controller.forward();

    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => HomePage(),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
          transitionDuration: Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF25488E),
      body: Stack(
        children: [
          // خلفية متحركة
          Positioned.fill(
            child: AnimatedBackground(),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // الشعار مع تأثيرات الحركة
                SlideTransition(
                  position: _logoSlideAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: RotationTransition(
                      turns: _rotationAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Image.asset(
                          'assets/images/logo.png', // تأكد من وجود الصورة في المسار الصحيح
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // النص مع تأثير الانزلاق
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        Text(
                          'إيجارك',
                          style: GoogleFonts.tajawal(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black.withOpacity(0.3),
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 10),

                        Text(
                          'منصة التأجير الأولى',
                          style: GoogleFonts.tajawal(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.9),
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // مؤشر التحميل في الأسفل
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 150,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF4C42D)),
                  minHeight: 5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// خلفية متحركة مع فقاعات (نفس الكود السابق)
class AnimatedBackground extends StatefulWidget {
  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Bubble> bubbles = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat();

    // إنشاء فقاعات عشوائية
    for (int i = 0; i < 20; i++) {
      bubbles.add(Bubble());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // تحديث مواقع الفقاعات
        bubbles.forEach((bubble) => bubble.update());

        return CustomPaint(
          painter: BubblePainter(bubbles: bubbles),
        );
      },
    );
  }
}

class Bubble {
  double x = Random().nextDouble();
  double y = Random().nextDouble();
  double size = Random().nextDouble() * 10 + 5;
  double speed = Random().nextDouble() * 0.5 + 0.1;
  Color color = Colors.white.withOpacity(Random().nextDouble() * 0.2 + 0.05);

  void update() {
    y -= speed / 100;
    if (y < -0.2) {
      y = 1.2;
      x = Random().nextDouble();
    }
  }
}

class BubblePainter extends CustomPainter {
  final List<Bubble> bubbles;

  BubblePainter({required this.bubbles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var bubble in bubbles) {
      paint.color = bubble.color;
      canvas.drawCircle(
        Offset(bubble.x * size.width, bubble.y * size.height),
        bubble.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
