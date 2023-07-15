import 'package:flutter/material.dart';

class MessagesTab extends StatelessWidget {
  const MessagesTab({super.key});

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //     itemCount: messages.length,
    //     shrinkWrap: true,
    //     itemBuilder: (context, index) {
    //       return ListTile(
    //         leading: CircleAvatar(
    //             backgroundImage: AssetImage(notification[index].image)),
    //         title: Text(
    //           notification[index].name,
    //           style: TextStyle(color: secondaryColor),
    //         ),
    //         subtitle: Row(
    //           children: <Widget>[
    //             Expanded(
    //               child: Text(
    //                 messages[index]!,
    //                 style: TextStyle(color: lightTextColor),
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ),
    //           ],
    //         ),
    //         trailing: Text(
    //           notification[index].time,
    //           style: TextStyle(color: lightTextColor.withOpacity(0.15)),
    //         ),
    //         onTap: () => Navigator.pushNamed(context, PageRoutes.chatPage),
    //       );
    //     });
    return Container();
  }
}
