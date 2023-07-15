import 'package:flutter/material.dart';

class NotifAvatar extends StatefulWidget {
  final Future<String> avatar;
  const NotifAvatar({super.key, required this.avatar});

  @override
  State<NotifAvatar> createState() => _NotifAvatarState();
}

class _NotifAvatarState extends State<NotifAvatar> {
  String? avatar;
  @override
  void initState() {
    super.initState();
    widget.avatar.then((value) {
      setState(() {
        avatar = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: avatar != null ? NetworkImage(avatar!) : null,
      child: avatar == null
          ? Icon(
              Icons.person,
              color: Colors.white,
              size: 26,
            )
          : Container(),
    );
  }
}
