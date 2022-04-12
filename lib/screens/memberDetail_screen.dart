import 'package:flutter/material.dart';
import 'package:mocozi/model/user.dart';
import 'package:mocozi/utils/colors.dart';

class MemberDetailScreen extends StatelessWidget {
  const MemberDetailScreen({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    var list = [
      Padding(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Text("성별/나이", style: TextStyle(color: primaryColor)),
      ),
      Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Text(user.gender!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Text("/"),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Text((DateTime.now().year - user.birthYear! + 1).toString(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Text("학과/학교", style: TextStyle(color: primaryColor)),
      ),
      Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Text(user.dep!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Text("/"),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Text(user.uni!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Text("자기소개", style: TextStyle(color: primaryColor)),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Text(user.bio!, style: TextStyle(fontSize: 16)),
      ),
    ];
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    ));
  }
}
