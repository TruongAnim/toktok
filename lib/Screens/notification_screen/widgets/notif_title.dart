import 'package:flutter/material.dart';
import 'package:toktok/Theme/colors.dart';

class NotifTitle extends StatefulWidget {
  final Future<String> name;
  final String title;
  const NotifTitle({super.key, required this.name, required this.title});

  @override
  State<NotifTitle> createState() => _NotifTitleState();
}

class _NotifTitleState extends State<NotifTitle> {
  String? name;
  @override
  void initState() {
    super.initState();
    widget.name.then((value) {
      setState(() {
        name = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return name == null
        ? Text(
            'user ${widget.title}',
            style: TextStyle(color: secondaryColor),
          )
        : Text(
            '$name ${widget.title}',
            style: TextStyle(color: secondaryColor),
          );
  }
}
