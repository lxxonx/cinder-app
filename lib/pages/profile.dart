import 'package:cinder/pages/edit.dart';
import 'package:cinder/pages/settings.dart';
import 'package:cinder/widgets/circleImage.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.blueGrey, opacity: 40),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Flexible(
                flex: 2,
                child: Column(
                  children: const <Widget>[
                    CircleImage(
                        imgUrl:
                            "https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg"),
                    Text(
                      "ddf",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.blueGrey,
                height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(_openSettings());
                      },
                      child: const Text('Go Setting'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(_openEdit());
                      },
                      child: const Text('Go Edit'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Route _openSettings() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const SettingsScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
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

Route _openEdit() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const EditScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
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
