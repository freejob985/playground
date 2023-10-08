import 'package:flutter/material.dart';

class AlertDialogExample extends StatefulWidget {
  
  const AlertDialogExample({Key? key}) : super(key: key);

  @override
  State<AlertDialogExample> createState() => _AlertDialogExampleState();
}

class _AlertDialogExampleState extends State<AlertDialogExample> {
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            // تعيين اللون الذي تريده هنا
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                color: const Color(0xFF383780),
                width: double.infinity,
                child: const Text(
                  'أيام الأسبوع',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontFamily: 'Al-Jazeera',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDayButton('السبت'),
              _buildDayButton('الأحد'),
              _buildDayButton('الاثنين'),
              _buildDayButton('الثلاثاء'),
              _buildDayButton('الأربعاء'),
              _buildDayButton('الخميس'),
              _buildDayButton('الجمعة'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDayButton(String day) {
    return ListTile(
      title: Text(
        day,
        style: TextStyle(
          fontSize: 13,
          color: Colors.black54,
          fontFamily: 'Al-Jazeera',
        ),
        textAlign: TextAlign.center,
      ),
      onTap: () {
    // إغلاق الحوار
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showDialog(context);
      },
      child: Text('عرض القائمة'),
    );
  }
}
