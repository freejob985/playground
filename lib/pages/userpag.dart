import 'package:flutter/material.dart';
import 'package:playground/helper/helper.dart';
import 'package:playground/widgets/MyDrawer.dart';

class Userpag extends StatefulWidget {
  const Userpag({Key? key}) : super(key: key);

  @override
  _UserpagState createState() => _UserpagState();
}

class _UserpagState extends State<Userpag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        elevation: 0,
        backgroundColor: primary,
      ),
      drawer: MyDrawer(),
      body: Container(),
    );
  }
}
