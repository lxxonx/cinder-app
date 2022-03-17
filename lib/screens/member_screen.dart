import 'package:flutter/material.dart';
import 'package:mocozi/model/user.dart';

class MemberCardScreen extends StatelessWidget {
  const MemberCardScreen({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    var list = [
      Container(
        width: 450,
        height: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            image: NetworkImage(
                user.pics![0].url.split(".jpg")[0] + "_8.jpg?alt=media"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(user.bio!),
      ),
      ...user.pics!.map((e) {
        if (user.pics!.indexOf(e) == 0) return Container();
        return Container(
          width: 450,
          height: 450,
          margin: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
              image: NetworkImage(e.url.split(".jpg")[0] + "_8.jpg?alt=media"),
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    ];
    return SingleChildScrollView(
        child: Column(
      children: list,
    ));
  }
}
