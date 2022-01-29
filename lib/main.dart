import 'package:cinder/pages/chat.dart';
import 'package:cinder/pages/explore.dart';
import 'package:cinder/pages/home.dart';
import 'package:cinder/pages/login.dart';
import 'package:cinder/pages/profile.dart';
import 'package:cinder/pages/signup.dart';
import 'package:cinder/resources/auth_methods.dart';
import 'package:cinder/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? isViewed;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getBool('onBoard');
  String? token = await AuthMethods().getCurrentUser();
  if (token == null) {
    prefs.setBool('onBoard', false);
  }

  runApp(Cinder());
}

class Cinder extends StatelessWidget {
  const Cinder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.authStateChanges());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            return Navigation();
          } else {
            return LoginScreen();
          }
        },
      ),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: primaryColor)),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      initialRoute: "/",
      routes: {
        "/login": (context) => LoginScreen(),
        "/signup": (context) => SignUpScreen(),
        "/home": (context) => const Navigation(),
      },
    );
  }
}

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    ExploreScreen(),
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
          icon: Icon(
            Icons.account_tree,
            color: primaryColor,
          ),
          onPressed: () {
            // go to profile
            Navigator.of(context).push(_createRoute());
          },
        ),
        title: Text(
          'cinder',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.w800),
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
          selectedItemColor: primaryColor,
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
        const ProfileScreen(name: "name"),
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
