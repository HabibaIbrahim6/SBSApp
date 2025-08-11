import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'add_product.dart';

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'لوحة تحكم التأجير',
      theme: ThemeData(
        fontFamily: 'Cairo',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF25488E)),
          bodyMedium: TextStyle(color: Color(0xFF25488E)),
          titleLarge: TextStyle(color: Color(0xFF25488E)),
          titleMedium: TextStyle(color: Color(0xFF25488E)),
          titleSmall: TextStyle(color: Color(0xFF25488E)),
          labelLarge: TextStyle(color: Color(0xFF25488E)),
          labelMedium: TextStyle(color: Color(0xFF25488E)),
          labelSmall: TextStyle(color: Color(0xFF25488E)),
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF25488E),
          secondary: const Color(0xFFF4C42D),
          surface: Colors.white,
          background: const Color(0xFFF5F5F5),
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: const Color(0xFF25488E),
          onBackground: const Color(0xFF25488E),
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const DashboardScreen(),
      routes: {
        '/add_product': (context) => const AddProductScreen(),
      },
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  bool _showProfileOptions = false;
  String _name = "محمد أحمد";
  String _email = "mohamed@example.com";
  String _phone = "+20123456789";
  File? _profileImage;

  final List<Map<String, dynamic>> rentedItems = [
    {
      'title': 'آيفون 15 برو ماكس',
      'image': 'assets/images/iphone.png',
      'date': 'تم التأجير: 15/03/2023',
      'status': 'مكتمل',
    },
    {
      'title': 'كاميرا احترافية',
      'image': 'assets/images/camera.png',
      'date': 'تم التأجير: 22/03/2023',
      'status': 'مكتمل',
    },
  ];

  final List<Map<String, dynamic>> uploadedItems = [
    {
      'title': 'ماك بوك برو',
      'image': 'assets/images/macbook.png',
      'date': 'تم الرفع: 10/03/2023',
      'status': 'متاح',
    },
    {
      'title': 'درون DJI',
      'image': 'assets/images/drone.png',
      'date': 'تم الرفع: 05/03/2023',
      'status': 'متاح',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF25488E)),
          onPressed: () {
            // العودة إلى الشاشة الرئيسية
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        title: Text(
          'لوحه التحكم',
          style: GoogleFonts.tajawal(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF25488E),
          ),
        ),
        centerTitle: true,
      ),

      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // بطاقة الملف الشخصي
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showProfileOptions = !_showProfileOptions;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: const Color(0xFFF5F5F5),
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!)
                                : const AssetImage('assets/images/profile.jpg') as ImageProvider,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF25488E),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _email,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    _buildStatItem(uploadedItems.length.toString(), 'عنصر مرفوع'),
                                    const SizedBox(width: 16),
                                    _buildStatItem(rentedItems.length.toString(), 'تم تأجيره'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            _showProfileOptions ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            size: 30,
                            color: const Color(0xFF25488E),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                if (_showProfileOptions)
                  AnimatedOpacity(
                    opacity: _showProfileOptions ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: _buildProfileOptions(),
                  ),

                const SizedBox(height: 20),
                _buildNavigationTabs(),
                const SizedBox(height: 20),

                _selectedIndex == 0
                    ? _buildUploadedItemsList()
                    : _buildRentedItemsList(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_product');
        },
        backgroundColor: const Color(0xFFF4C42D),
        child: const Icon(Icons.add, color: Color(0xFF25488E)),
      ),
    );
  }

  Widget _buildProfileOptions() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildProfileOptionTile(
            icon: Icons.camera_alt,
            title: 'تحديث الصورة الشخصية',
            onTap: _showImagePickerDialog,
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _buildProfileOptionTile(
            icon: Icons.lock,
            title: 'تغيير كلمة المرور',
            onTap: _showChangePasswordDialog,
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _buildProfileOptionTile(
            icon: Icons.phone,
            title: 'تحديث رقم الهاتف',
            onTap: _showUpdatePhoneDialog,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF25488E)),
      title: Text(title, style: const TextStyle(color: Color(0xFF25488E))),
      onTap: onTap,
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF25488E),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationTabs() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton(0, 'المنتجات المرفوعة'),
          ),
          Expanded(
            child: _buildTabButton(1, 'التأجيرات السابقة'),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(int index, String title) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: _selectedIndex == index ? const Color(0xFF25488E) : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: _selectedIndex == index ? Colors.white : const Color(0xFF25488E),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadedItemsList() {
    return Column(
      children: uploadedItems.map((item) => _buildItemCard(item)).toList(),
    );
  }

  Widget _buildRentedItemsList() {
    return Column(
      children: rentedItems.map((item) => _buildItemCard(item)).toList(),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(item['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF25488E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['date'],
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: item['status'] == 'متاح'
                            ? const Color(0xFFF4C42D).withOpacity(0.2)
                            : const Color(0xFF25488E).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        item['status'],
                        style: TextStyle(
                          color: item['status'] == 'متاح'
                              ? const Color(0xFFF4C42D)
                              : const Color(0xFF25488E),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
                color: const Color(0xFF25488E),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'اختر مصدر الصورة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF25488E),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildImageSourceButton(
                      icon: Icons.camera_alt,
                      label: 'الكاميرا',
                      onPressed: () async {
                        Navigator.pop(context);
                        final image = await ImagePicker().pickImage(source: ImageSource.camera);
                        if (image != null) {
                          setState(() {
                            _profileImage = File(image.path);
                          });
                        }
                      },
                    ),
                    _buildImageSourceButton(
                      icon: Icons.photo_library,
                      label: 'المعرض',
                      onPressed: () async {
                        Navigator.pop(context);
                        final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          setState(() {
                            _profileImage = File(image.path);
                          });
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('إلغاء', style: TextStyle(color: Color(0xFF25488E))),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSourceButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 40),
          color: const Color(0xFF25488E),
          onPressed: onPressed,
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Color(0xFF25488E))),
      ],
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'تغيير كلمة المرور',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF25488E),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'كلمة المرور الحالية',
                      labelStyle: const TextStyle(color: Color(0xFF25488E)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF25488E)),
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Color(0xFF25488E)),
                    ),
                    style: const TextStyle(color: Color(0xFF25488E)),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'كلمة المرور الجديدة',
                      labelStyle: const TextStyle(color: Color(0xFF25488E)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF25488E)),
                      ),
                      prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF25488E)),
                    ),
                    style: const TextStyle(color: Color(0xFF25488E)),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'تأكيد كلمة المرور',
                      labelStyle: const TextStyle(color: Color(0xFF25488E)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF25488E)),
                      ),
                      prefixIcon: const Icon(Icons.lock_reset, color: Color(0xFF25488E)),
                    ),
                    style: const TextStyle(color: Color(0xFF25488E)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF25488E),
                            side: const BorderSide(color: Color(0xFF25488E)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('إلغاء'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF25488E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('تم تغيير كلمة المرور بنجاح'),
                                backgroundColor: const Color(0xFF25488E),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                          },
                          child: const Text('حفظ', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showUpdatePhoneDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'تحديث رقم الهاتف',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF25488E),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'رقم الهاتف الجديد',
                      labelStyle: const TextStyle(color: Color(0xFF25488E)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF25488E)),
                      ),
                      prefixIcon: const Icon(Icons.phone, color: Color(0xFF25488E)),
                    ),
                    style: const TextStyle(color: Color(0xFF25488E)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF25488E),
                            side: const BorderSide(color: Color(0xFF25488E)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('إلغاء'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF25488E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('تم تحديث رقم الهاتف بنجاح'),
                                backgroundColor: const Color(0xFF25488E),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                          },
                          child: const Text('حفظ', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}