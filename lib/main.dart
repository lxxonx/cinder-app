import 'package:cinder/pages/chat.dart';
import 'package:cinder/pages/home.dart';
import 'package:cinder/pages/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Navigation(),
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.pink)))));
}

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const Text(
      'Explore',
      style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
    ),
    const Text(
      'Places',
      style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
    ),
    ChatScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.account_tree,
            color: Colors.pink,
          ),
          onPressed: () {
            // go to profile
            Navigator.of(context).push(_createRoute());
          },
        ),
        title: const Text(
          'cinder',
          style: TextStyle(color: Colors.pink, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsetsGeometry.lerp(EdgeInsets.zero, EdgeInsets.zero, 2),
        color: Colors.white,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.compass_calibration),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: "",
            )
          ],
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: Colors.pink,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const ProfileScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
