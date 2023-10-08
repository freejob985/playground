// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../helper/helper.dart';

class CustomFormTextField extends StatelessWidget {
  String? labelText;
  TextEditingController? text_;
  final VoidCallback? onTap_;
  TextInputType? keyboardType; // متغير لتحديد نوع لوحة المفاتيح

  CustomFormTextField({
    required this.labelText,
    required this.text_,
    this.onTap_,
    this.keyboardType, // قم بإضافة المتغير كمتغير اختياري
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // تغيير الاتجاه إلى RTL
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: TextFormField(
          controller: text_,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
          style: TextStyle(
            color: Colors.black,
            fontFamily: Jazeera,
            fontSize: 15, // حجم الخط
          ),
          decoration: InputDecoration(
            labelText: labelText,
            floatingLabelBehavior:
                FloatingLabelBehavior.auto, // تحديد سلوك الوسم
            labelStyle: TextStyle(color: Colors.black),
            border: InputBorder.none, // إزالة الحدود,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.0),
              borderSide: BorderSide(color: Colors.white),
            ),
            filled: true,
            fillColor: primary_,
          ),
          obscureText: false,
          onTap: onTap_,
          keyboardType: keyboardType, // قم بتمرير نوع لوحة المفاتيح هنا
        ),
      ),
    );
  }
}
