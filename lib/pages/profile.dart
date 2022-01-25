import 'package:cinder/pages/edit.dart';
import 'package:cinder/pages/settings.dart';
import 'package:cinder/widgets/circleImage.dart';
import 'package:cinder/widgets/circleProfile.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, required this.name, this.imgUrl})
      : super(key: key);

  final String name;
  final String? imgUrl;

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
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(_openEdit("preview"));
                      },
                      child: imgUrl != null
                          ? CircleProfile(image: NetworkImage(imgUrl!))
                          : CircleProfile(
                              image: NetworkImage(
                                  "https://www.acumarketing.com/acupuncture-websites/wp-content/uploads/2020/01/anonymous-avatar-sm.jpg")),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
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
                            Navigator.of(context).push(_openEdit("edit"));
                          },
                          child: const Text('Go Edit'),
                        ),
                      ],
                    ),
                  ],
                )),
            Flexible(
              flex: 1,
              child: Container(
                  color: Colors.blueGrey,
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(child: Text("hd"))),
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

Route _openEdit(String state) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        ProfileEditScreen(state: state),
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
