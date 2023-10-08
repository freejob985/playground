import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:playground/helper/helper.dart';

class CustomElevatedButton extends StatelessWidget {
  final String data;
  final IconData star;
  final Function()? onChanged_;

  CustomElevatedButton({
    required this.data,
    required this.star,
  required  this.onChanged_,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30),
      child: ElevatedButton(
        onPressed: onChanged_,
        style: ElevatedButton.styleFrom(
          primary: primary, // لون الخلفية
          onPrimary: Colors.white, // لون الكتابة
          elevation: 3, // الارتفاع
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0), // حدود مستديرة
            side: const BorderSide(color: primary), // لون البوردر
          ),
          textStyle: const TextStyle(
            fontFamily: Jazeera, // الخط
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FaIcon(
              star,
              size: sizeicon,
            ), // أيقونة
            // تباعد بين الأيقونة والنص
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(data),
            ), // نص الزر
          ],
        ),
      ),
    );
  }
}
