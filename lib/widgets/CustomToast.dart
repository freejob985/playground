import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:playground/helper/helper.dart';

class CustomToast extends StatelessWidget {
  final String message;

  CustomToast({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.blue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: Jazeera,
          fontSize: 10.0,
          color: Colors.white,

          // يمكنك تخصيص المزيد من الخصائص هنا
        ),
      ),
    );
  }
}
