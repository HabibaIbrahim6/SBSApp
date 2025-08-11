import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/product_details.dart';
import 'account_typePage.dart';
import 'ContactUS.dart';
import 'FilterPage.dart';
import 'aboutUs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// صفحة تفاصيل المنتج الجديدة

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool userIsLoggedIn = false;

  final List<Widget> _pages = [
    HomeContent(),
    AccountTypePage(),
    ContactUsPage(),
    AboutUsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart, color: Color(0xFFF4C42D)),
              SizedBox(width: 8),
              Text(
                'إيجارك',
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
                if (!userIsLoggedIn) {
                  Navigator.pushNamed(context, '/login');
                } else {
                  // افتح صفحة الملف الشخصي
                }
              },
            ),
          ],
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: _buildBottomNavBar(),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF25488E),
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: GoogleFonts.tajawal(fontWeight: FontWeight.bold),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'نوع الحساب',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail),
              label: 'تواصل معنا',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'من نحن',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSearchBar(context),
          _buildCarItem(
            'تويوتا كورولا',
            'مسطرة - القاهرة',
            'assets/toyota.jpg',
            onDetails: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductDetailPage()),
              );
            },
          ),
          // ممكن تضيفي سيارات تانية هنا
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'إبحث بالاسم أو المنطقة',
                prefixIcon: Icon(Icons.search, color: Color(0xFF212121)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Color(0xFF25488E),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(Icons.tune, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdvancedFilterPage()),
                );
              },
              tooltip: 'فلترة',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarItem(
      String title, String location, String imagePath, {VoidCallback? onDetails}) {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Image.asset(imagePath,
              height: 150, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF212121))),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Color(0xFF212121)),
                    SizedBox(width: 4),
                    Text(location, style: TextStyle(color: Color(0xFF212121))),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.star, color: Color(0xFFF4C42D)),
                    Icon(Icons.star, color: Color(0xFFF4C42D)),
                    Icon(Icons.star, color: Color(0xFFF4C42D)),
                    Icon(Icons.star, color: Color(0xFFF4C42D)),
                    Icon(Icons.star, color: Color(0xFFF4C42D)),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onDetails,
                  child: Text('عرض تفاصيل المنتج',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF25488E),
                    minimumSize: Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
