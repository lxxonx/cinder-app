import 'package:app/widgets/swipeableCard.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  onTapLike() {
    print("liked");
  }

  onTapDislike() {
    print("dislike");
  }

  onTapSuperlike() {
    print("superlike");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(5, 20, 5, 40),
        child: Stack(
          children: [
            SwipeableCard(
              onTapDislike: onTapDislike(),
              onTapLike: onTapLike(),
              onTapSuperlike: onTapSuperlike(),
            )
          ],
        ));
  }
}
