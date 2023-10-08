import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyListView(),
    );
  }
}

class MyListView extends StatelessWidget {
  final List<String> items =
      List.generate(50, (index) => 'Item $index'); // قائمة العناصر

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Example'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(items[index]),
            onTap: () {
              // يمكنك إضافة السلوك الذي تريده هنا عند النقر على العنصر
              // مثل الانتقال إلى صفحة أخرى أو إجراء إجراء معين.
            },
          );
        },
      ),
    );
  }
}
