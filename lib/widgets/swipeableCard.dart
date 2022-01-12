import 'package:app/pages/detail.dart';
import 'package:app/widgets/circleButton.dart';
import 'package:flutter/material.dart';

class SwipeableCard extends StatefulWidget {
  const SwipeableCard({
    Key? key,
    required this.onTapDislike,
    required this.onTapLike,
    required this.onTapSuperlike,
    this.info,
  }) : super(key: key);

  final Function onTapLike;
  final Function onTapDislike;
  final Function onTapSuperlike;
  final info;

  @override
  State<SwipeableCard> createState() => SwipeableCardState();
}

class SwipeableCardState extends State<SwipeableCard> {
  static const List<ImageProvider> pics = [
    AssetImage("images/beauty1.jpeg"),
    AssetImage("images/beauty2.jpeg"),
    AssetImage("images/beauty3.jpeg"),
    AssetImage("images/beauty4.jpeg"),
  ];
  int _currentPicIndex = 0;
  @override
  Widget build(BuildContext context) {
    print(widget.info);
    return GestureDetector(
      onPanDown: (DragDownDetails) {
        print(DragDownDetails);
      },
      child: Card(
        elevation: 5,
        clipBehavior: Clip.none,
        child: Stack(
          children: [
            Hero(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    image: DecorationImage(
                        image: pics[_currentPicIndex], fit: BoxFit.cover)),
                margin: EdgeInsets.zero,
              ),
              tag: "profile_pics",
            ),
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
                      const Text("name",
                          style: TextStyle(
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
              const Text("personal bio", style: TextStyle(color: Colors.white))
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlineCircleButton(
            borderColor: Colors.yellow,
            borderSize: 1.0,
            radius: 40.0,
            child: const Icon(
              Icons.ac_unit,
              color: Colors.yellow,
            ),
            onPressed: () {
              // undo
            },
          ),
          OutlineCircleButton(
              borderColor: Colors.red,
              borderSize: 1.0,
              radius: 50.0,
              child: const Icon(
                Icons.ac_unit,
                color: Colors.red,
              ),
              onPressed: () => widget.onTapDislike()),
          OutlineCircleButton(
              borderColor: Colors.blue,
              borderSize: 1.0,
              radius: 40.0,
              child: const Icon(
                Icons.ac_unit,
                color: Colors.blue,
              ),
              onPressed: () => widget.onTapSuperlike()),
          OutlineCircleButton(
              borderColor: Colors.green,
              borderSize: 1.0,
              radius: 50.0,
              child: const Icon(
                Icons.ac_unit,
                color: Colors.green,
              ),
              onPressed: () => widget.onTapLike()),
          OutlineCircleButton(
            borderColor: Colors.purple,
            borderSize: 1.0,
            radius: 40.0,
            child: const Icon(
              Icons.ac_unit,
              color: Colors.purple,
            ),
            onPressed: () {
              // boost
            },
          ),
        ],
      ),
    );
  }

  prevPic() {
    print("prevPic");
    if (_currentPicIndex > 0) {
      setState(() {
        _currentPicIndex--;
      });
    } else {
      // move card for nudge;
    }
    return null;
  }

  nextPic() {
    print("nextPic");
    if (_currentPicIndex < pics.length - 1) {
      setState(() {
        _currentPicIndex++;
      });
    } else {
      // move card for nudge;
    }
    return null;
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
