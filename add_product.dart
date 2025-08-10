import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const AddProductScreen(),
    );
  }
}

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  final List<String> _categories = [
    'الكترونيات',
    'أثاث',
    'أدوات منزلية',
    'ملابس',
    'أخرى'
  ];
  List<String> _selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'إضافة منتج جديد',
          style: TextStyle(
            color: Color(0xFF212121),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF212121)),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4C42D).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'قم بإضافة منتجك وابدأ في عرضه للتأجير',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF212121),
                      ),
                    ),
                    const SizedBox(height: 8),

                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Product Name Field
              const Text(
                'اسم المنتج',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'أدخل اسم المنتج',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب إدخال اسم المنتج';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Product Category Field
              const Text(
                'اختر فئة المنتج',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                isExpanded: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                hint: const Text(
                  'اختر الفئة',
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.grey),
                ),
                items: _categories.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, textAlign: TextAlign.right),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب اختيار فئة المنتج';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Product Price Field
              const Text(
                'سعر المنتج',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'أدخل السعر اليومي',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 16, right: 8),
                    child: Text(
                      'ر.س',
                      style: TextStyle(
                        color: Color(0xFF25488E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  prefixIconConstraints:
                  const BoxConstraints(minWidth: 0, minHeight: 0),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب إدخال سعر المنتج';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Product Description Field
              const Text(
                'وصف المنتج',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                textAlign: TextAlign.right,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'أدخل وصفاً تفصيلياً للمنتج',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب إدخال وصف المنتج';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Product Images Upload
              const Text(
                'صور المنتج',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // Handle image selection
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.cloud_upload_rounded,
                        size: 40,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _selectedImages.isEmpty
                            ? 'No file chosen'
                            : '${_selectedImages.length} ملفات مختارة',
                        style: TextStyle(
                          color: _selectedImages.isEmpty
                              ? Colors.grey
                              : const Color(0xFF25488E),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF25488E),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'اختر ملفات',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, proceed with submission
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF25488E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'إضافة المنتج',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
