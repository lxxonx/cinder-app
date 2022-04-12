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
      const Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12.0),
        child: Text("자기소개"),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12.0),
        child: Text(user.bio!),
      ),
      ...user.pics!.map((e) {
        if (user.pics!.indexOf(e) == 0) return Container();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 450,
              height: 450,
              margin: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image:
                      NetworkImage(e.url.split(".jpg")[0] + "_8.jpg?alt=media"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 12.0),
              child: Text("나이"),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 12.0),
              child: Text(
                  (DateTime.now().year - user.birthYear! + 1).toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      }).toList(),
    ];
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    ));
  }
}
