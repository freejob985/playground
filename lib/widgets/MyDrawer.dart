import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:playground/helper/helper.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                'ملعب نادي السلام',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: Jazeera,
                ),
              ),
              accountEmail: Text(''),
              // currentAccountPicture: CircleAvatar(
              //   backgroundColor: Colors.white,
              //   child: Icon(
              //     Icons.person,
              //     color: primary,
              //   ),
              // ),
              decoration: BoxDecoration(
                color: primary,
              ),
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.home),
              title: Text('الرئسية',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontFamily: Jazeera,
                  )),
              onTap: () {
                Navigator.pushNamed(context, "Home");
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.home),
              title: Text('اضافة حجز',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontFamily: Jazeera,
                  )),
              onTap: () {
                // أدخل العمليات التي تريدها هنا
                Navigator.pushNamed(context, "AddReservation");
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.cog),
              title: Text('الحجوزات',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontFamily: Jazeera,
                  )),
              onTap: () {
                // أدخل العمليات التي تريدها هنا
                Navigator.pushNamed(context, "Reservation");
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.cog),
              title: Text('حجوزات اليوم',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontFamily: Jazeera,
                  )),
              onTap: () {
                // أدخل العمليات التي تريدها هنا
                Navigator.pushNamed(context, "Addres");
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.cog),
              title: Text('الأسماء',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontFamily: Jazeera,
                  )),
              onTap: () {
                Navigator.pushNamed(context, "Showpeople");
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.cog),
              title: Text('تسليم نقدية',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontFamily: Jazeera,
                  )),
              onTap: () {
                Navigator.pushNamed(context, "Cashpag");
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.cog),
              title: Text(' الحسابات',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontFamily: Jazeera,
                  )),
              onTap: () {
                Navigator.pushNamed(context, "Accounts");
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.cog),
              title: Text(' المستخدم',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontFamily: Jazeera,
                  )),
              onTap: () {
                Navigator.pushNamed(context, "Updateuser");
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.cog),
              title: Text(' تسجيل الخروج',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontFamily: Jazeera,
                  )),
              onTap: () async {
                // await sql_.updateRow("user", {'st': 0}, 1);
                Navigator.pushNamed(context, "login");
              },
            ),
            // يمكنك إضافة المزيد من العناصر هنا
          ],
        ),
      ),
    );
  }
}
