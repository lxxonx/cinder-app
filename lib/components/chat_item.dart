import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 80,
        child: InkWell(
            child: Row(
          children: [
            Container(
                height: 75,
                width: 75,
                child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToxtcl-1iO_yF8nszUob_EssatZo8c_aZbuwiH_IxKpHXL3iUI03IRkfkUfX0GPwpzsHg&usqp=CAU")),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    letterSpacing: -1,
                  ),
                ),
                Text("last message")
              ],
            )
          ],
        )),
      ),
      onTap: () {
        // move to chat
      },
    );
  }
}
