import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF25488E),
        elevation: 4,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 8),

            Text(
              'إضافة منتج جديد',
              style: GoogleFonts.tajawal(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),


        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF212121)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
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
              // Container(
              //   width: double.infinity,
              //   padding: const EdgeInsets.all(20),
              //   decoration: BoxDecoration(
              //     color: const Color(0xFFF4C42D).withOpacity(0.1),
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           Text(
              //             'قم بإضافة منتجك وابدأ في عرضه للتأجير',
              //             textAlign: TextAlign.right,
              //             style: GoogleFonts.tajawal(
              //               color: const Color(0xFF212121),
              //               fontSize: 16,
              //             ),
              //           ),
              //         ],
              //       ),
              //
              //       const SizedBox(height: 8),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 30),

              // Product Name Field
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'اسم المنتج',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF212121),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 8),
              TextFormField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'أدخل اسم المنتج',
                  hintStyle: GoogleFonts.tajawal(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF25488E),
                      width: 1.5,
                    ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'اختر فئة المنتج',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF212121),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                isExpanded: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF25488E),
                      width: 1.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                hint: Text(
                  'اختر الفئة',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.tajawal(color: Colors.grey),
                ),
                items: _categories.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        textAlign: TextAlign.right, style: GoogleFonts.tajawal()),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'سعر المنتج',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF212121),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              TextFormField(
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'أدخل السعر اليومي',
                  hintStyle: GoogleFonts.tajawal(color: Colors.grey),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8),
                    child:
                    Text(
                      'ج.م',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.tajawal(
                        color: const Color(0xFF25488E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  prefixIconConstraints:
                  const BoxConstraints(minWidth: 0, minHeight: 0),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF25488E),
                      width: 1.5,
                    ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'وصف المنتج',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF212121),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              TextFormField(
                textAlign: TextAlign.right,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'أدخل وصفاً تفصيلياً للمنتج',
                  hintStyle: GoogleFonts.tajawal(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF25488E),
                      width: 1.5,
                    ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'صور المنتج',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF212121),
                      fontSize: 16,
                    ),
                  ),
                ],
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
                    color: Colors.grey[100],
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
                            ? 'لا يوجد ملفات مختارة'
                            : '${_selectedImages.length} ملفات مختارة',
                        style: TextStyle(
                          color: _selectedImages.isEmpty
                              ? Colors.grey
                              : const Color(0xFF25488E),
                          fontFamily: GoogleFonts.tajawal().fontFamily,
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
                        child: Text(
                          'اختر ملفات',
                          style: GoogleFonts.tajawal(
                            color: Colors.white,
                          ),
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
                    backgroundColor: const Color(0xFFF4C42D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'إضافة المنتج',
                    style: GoogleFonts.tajawal(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF212121),
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
