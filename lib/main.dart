import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testtting/Constants/Constants.dart';
import 'package:testtting/UI/Analytics/Analytics.dart';
import 'package:testtting/UI/Contacts/Contacts.dart';
import 'package:testtting/UI/Profile/Profile.dart';
import 'package:testtting/UI/Share/Share.dart';
import 'package:testtting/UI/StartingScreen/startup.dart';
import 'UI/Menu/Menu.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLogin') ?? false;
  runApp(MaterialApp(
    builder: EasyLoading.init(),
    debugShowCheckedModeBanner: false,
    home: isLoggedIn == true ? BottomNavigationBarExample()  : IntialView(),
  ));
  configLoading();
}
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class BottomNavigationBarExample extends StatefulWidget {
  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Profile(),
    Contacts(),
    ShareTab(),
    Analytics(),
    MenuWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ConvexAppBar(
        curveSize: 1,
        cornerRadius: 20,
        style: TabStyle.fixedCircle,
        activeColor: Colors.grey,
        shadowColor: const Color.fromARGB(255, 231, 228, 228),
        backgroundColor: Colors.white,
        color: Colors.black,
        items: const [
          TabItem(
            fontFamily: Constants.fontFamily,
            icon: Icon(Icons.person, color: Colors.grey),
            title: 'Profile',
            // backgroundColor: Colors.red,
          ),
          TabItem(
            fontFamily: Constants.fontFamily,
            icon: Icon(Icons.contact_page_outlined, color: Colors.grey),
            title: 'Contact',
            //backgroundColor: Colors.green,
          ),
          TabItem(
            icon: Icon(Icons.share, color: Colors.white),
            title: 'Share',
          ),
          TabItem(
            fontFamily: Constants.fontFamily,
            icon: Icon(Icons.analytics, color: Colors.grey),
            title: 'Analytics',
            // backgroundColor: Colors.pink,
          ),
          TabItem(
            fontFamily: Constants.fontFamily,
            icon: Icon(Icons.menu, color: Colors.grey),
            title: 'Menu',
            // backgroundColor: Colors.pink,
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

