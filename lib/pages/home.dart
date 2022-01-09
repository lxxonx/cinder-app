import 'dart:ui';

import 'package:app/pages/detail.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _tilt = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(5, 20, 5, 40),
        child: Stack(
          children: [
            Card(
              elevation: 5,
              clipBehavior: Clip.none,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        image: DecorationImage(
                            image: AssetImage("images/beauty2.jpeg"),
                            fit: BoxFit.cover)),
                    margin: EdgeInsets.zero,
                  ),
                  Hero(
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          image: DecorationImage(
                              image: AssetImage("images/beauty1.jpeg"),
                              fit: BoxFit.cover)),
                      margin: EdgeInsets.zero,
                    ),
                    tag: "profile_pics",
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(_openDetail());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  Colors.transparent,
                                  Colors.black
                                ])),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text("name",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600)),
                                    Icon(
                                      Icons.info,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                const Text("distance",
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                                const Text("personal bio",
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          )),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4),
                                bottomRight: Radius.circular(4))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              child: const Icon(
                                Icons.ac_unit,
                                color: Colors.white,
                              ),
                              style: ButtonStyle(
                                  shape:
                                      MaterialStateProperty.all(CircleBorder()),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              onPressed: () {},
                            ),
                            ElevatedButton(
                              child: const Icon(
                                Icons.ac_unit,
                                color: Colors.white,
                              ),
                              style: ButtonStyle(
                                  shape:
                                      MaterialStateProperty.all(CircleBorder()),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue)),
                              onPressed: () {},
                            ),
                            ElevatedButton(
                              child: const Icon(
                                Icons.ac_unit,
                                color: Colors.white,
                              ),
                              style: ButtonStyle(
                                  // minimumsize:
                                  //     materialstateproperty.all(size(50, 50)),
                                  shape:
                                      MaterialStateProperty.all(CircleBorder()),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.green)),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

Route _openDetail() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const DetailScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 0.0);
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
