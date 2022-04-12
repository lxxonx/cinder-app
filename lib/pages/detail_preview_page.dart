import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mocozi/components/outline_circle_button.dart';
import 'package:mocozi/model/group.dart';
import 'package:mocozi/screens/memberDetail_screen.dart';
import 'package:mocozi/utils/colors.dart';

class DetailPreviewPage extends StatefulWidget {
  DetailPreviewPage({Key? key, required this.group}) : super(key: key);
  final Group group;
  @override
  _DetailPreviewPageState createState() => _DetailPreviewPageState();
}

class _DetailPreviewPageState extends State<DetailPreviewPage> {
  int _currentPageIndex = 0;
  List<Widget> pics = [];
  late Widget info;

  @override
  void initState() {
    super.initState();
    var gps = widget.group.pics.map<Widget>((p) {
      return (Container(
        width: 450,
        height: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            image: NetworkImage(p.url),
            fit: BoxFit.cover,
          ),
        ),
      ));
    }).toList();
    pics.addAll(gps);
    for (int i = 0; i < widget.group.members.length; i++) {
      var mps = widget.group.members[i].pics!.map<Widget>((p) {
        return Container(
          width: 450,
          height: 450,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
              image: NetworkImage(p.url.split(".jpg")[0] + "_8.jpg?alt=media"),
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList();
      pics.addAll(mps);
    }

    info = Container();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          ListView(
            children: [
              Container(
                width: 450,
                height: 450,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    pics[_currentPageIndex],
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                prevPage();
                              },
                            )),
                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                nextPage();
                              },
                            )),
                      ],
                    ),
                    Container(
                        transform: Matrix4.translationValues(0.0, 25.0, 0.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            Get.back();
                          },
                          backgroundColor: primaryColor,
                          child: Icon(Icons.arrow_downward_rounded),
                        ))
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text("그룹이름"),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Text(widget.group.groupname,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(widget.group.bio!),
                  )
                ],
              ),
              info,
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buttons(),
            ],
          )
        ],
      ),
    );
  }

  Widget buttons() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8, top: 0, left: 8, right: 8),
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4))),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlineCircleButton(
            borderColor: Colors.red,
            borderSize: 2.0,
            radius: 40.0,
            child: const Icon(
              Icons.close,
              color: Colors.red,
            ),
            onPressed: () {
              // undo
              Get.back();
              // widget.card.nope();
            },
          ),
          OutlineCircleButton(
            borderColor: Colors.green,
            borderSize: 2.0,
            radius: 40.0,
            child: const Icon(
              Icons.favorite,
              color: Colors.green,
            ),
            onPressed: () {
              // boost
              Get.back();
              // widget.card.like();
            },
          ),
        ],
      ),
    );
  }

  prevPage() {
    if (_currentPageIndex > 0) {
      setState(() {
        _currentPageIndex--;
        changeInfo();
      });
    } else {
      // move card for nudge;
      HapticFeedback.lightImpact();
    }
    return null;
  }

  nextPage() {
    if (_currentPageIndex < pics.length - 1) {
      setState(() {
        _currentPageIndex++;
        changeInfo();
      });
    } else {
      // move card for nudge;
      HapticFeedback.lightImpact();
    }
    return null;
  }

  changeInfo() {
    if (_currentPageIndex < widget.group.pics.length) {
      info = Container();
    } else if (_currentPageIndex <
        widget.group.pics.length + widget.group.members[0].pics!.length) {
      info = MemberDetailScreen(user: widget.group.members[0]);
    } else if (_currentPageIndex <
        widget.group.pics.length +
            widget.group.members[0].pics!.length +
            widget.group.members[1].pics!.length) {
      info = MemberDetailScreen(user: widget.group.members[1]);
    } else if (widget.group.members[2] != null &&
        _currentPageIndex <
            widget.group.pics.length +
                widget.group.members[0].pics!.length +
                widget.group.members[1].pics!.length +
                widget.group.members[2].pics!.length) {
      info = MemberDetailScreen(user: widget.group.members[2]);
    } else if (widget.group.members[3] != null &&
        _currentPageIndex <
            widget.group.pics.length +
                widget.group.members[0].pics!.length +
                widget.group.members[1].pics!.length +
                widget.group.members[2].pics!.length +
                widget.group.members[3].pics!.length) {
      info = MemberDetailScreen(user: widget.group.members[3]);
    }
  }
  // Route _openDetail() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => DetailScreen(
  //       profileInfo: widget.profileInfo,
  //       currentPicIndex: _currentPicIndex,
  //     ),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(0.0, 0.0);
  //       const end = Offset.zero;
  //       const curve = Curves.ease;

  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }
}
