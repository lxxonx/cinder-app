import 'package:mocozi/models/profileInfo.dart';
import 'package:mocozi/pages/detail.dart';
import 'package:mocozi/widgets/outlineCircleButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SwipeableCard extends StatefulWidget {
  const SwipeableCard({
    Key? key,
    required this.onTapDislike,
    required this.onTapLike,
    required this.onTapSuperlike,
    required this.profileInfo,
  }) : super(key: key);

  final Function onTapLike;
  final Function onTapDislike;
  final Function onTapSuperlike;
  final ProfileInfo profileInfo;

  @override
  State<SwipeableCard> createState() => SwipeableCardState();
}

class SwipeableCardState extends State<SwipeableCard> {
  int _currentPicIndex = 0;
  @override
  void initState() {
    super.initState();
    pics = widget.profileInfo.profilePics
        .map((pic) => Hero(
            tag: pic,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                image: DecorationImage(
                  image: NetworkImage(pic),
                  fit: BoxFit.cover,
                ),
              ),
            )))
        .toList();
  }

  List<Hero>? pics;

  @override
  Widget build(BuildContext context) {
    return Draggable(
      childWhenDragging: Card(
        elevation: 5,
        child: Container(
          child: pics![_currentPicIndex],
        ),
      ),
      feedback: Card(
        elevation: 5,
        child: Container(
          child: pics![_currentPicIndex],
        ),
      ),
      child: Card(
        elevation: 5,
        clipBehavior: Clip.none,
        child: Stack(
          children: [
            pics![_currentPicIndex],
            /*
            buttons
           */
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        prevPic();
                      },
                    )),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        nextPic();
                      },
                    )),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                info(),
                buttons(),
              ],
            )
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Positioned(
  //     child: Draggable(
  //       childWhenDragging: Container(),
  //       feedback: Card(
  //         elevation: 12,
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //         child: Container(
  //           width: 240,
  //           height: 300,
  //         ),
  //       ),
  //       child: Card(
  //         elevation: 12,
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //         child: Container(
  //           width: 240,
  //           height: 300,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget info() {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(_openDetail());
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black])),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.ideographic,
                    children: [
                      Text(widget.profileInfo.username,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32.0,
                              fontWeight: FontWeight.w600)),
                      Container(
                          margin: const EdgeInsets.only(left: 8),
                          child: const Text("age",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600))),
                    ],
                  ),
                  const Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                ],
              ),
              const Text(
                "distance",
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
              Text(widget.profileInfo.bio,
                  style: TextStyle(color: Colors.white))
            ],
          ),
        ));
  }

  Widget buttons() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8, top: 0, left: 8, right: 8),
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4))),
      height: 50,
    );
  }

  prevPic() {
    if (_currentPicIndex > 0) {
      setState(() {
        _currentPicIndex--;
      });
    } else {
      // move card for nudge;
      HapticFeedback.lightImpact();
    }
    return null;
  }

  nextPic() {
    if (_currentPicIndex < pics!.length - 1) {
      setState(() {
        _currentPicIndex++;
      });
    } else {
      // move card for nudge;
      HapticFeedback.lightImpact();
    }
    return null;
  }

  Route _openDetail() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => DetailScreen(
        profileInfo: widget.profileInfo,
        currentPicIndex: _currentPicIndex,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
