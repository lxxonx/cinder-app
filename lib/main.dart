import 'package:mocozi/pages/chat.dart';
import 'package:mocozi/pages/explore.dart';
import 'package:mocozi/pages/heart.dart';
import 'package:mocozi/pages/home.dart';
import 'package:mocozi/pages/login.dart';
import 'package:mocozi/pages/onBoard.dart';
import 'package:mocozi/pages/profile.dart';
import 'package:mocozi/pages/signup.dart';
import 'package:mocozi/resources/auth_methods.dart';
import 'package:mocozi/utils/colors.dart';
import 'package:mocozi/utils/logo.dart';
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
  runApp(Mocozi());
}

class Mocozi extends StatelessWidget {
  const Mocozi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.authStateChanges());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isViewed != null && isViewed == true
          ? OnBoardPage()
          : StreamBuilder(
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
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: secondaryColor,
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: primaryColor,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: secondaryColor,
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
  final _pageController = PageController();
  final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    ExploreScreen(),
    HeartScreen(),
    ChatScreen()
  ];
  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
        title: Logo(),
        backgroundColor: secondaryColor,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
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
            icon: Icon(Icons.favorite),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: "",
          )
        ],
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(), // No sliding
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
