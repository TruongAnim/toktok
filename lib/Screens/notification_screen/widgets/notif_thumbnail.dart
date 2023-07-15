import 'package:flutter/material.dart';

class NotifThumbnail extends StatefulWidget {
  final Future<String> thumbnail;
  const NotifThumbnail({super.key, required this.thumbnail});

  @override
  State<NotifThumbnail> createState() => _NotifThumbnailState();
}

class _NotifThumbnailState extends State<NotifThumbnail> {
  String? thumbnail;
  @override
  void initState() {
    super.initState();
    widget.thumbnail.then((value) {
      setState(() {
        thumbnail = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return thumbnail != null
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  image: Image.network(thumbnail!).image, fit: BoxFit.cover),
            ),
          )
        : const Row(children: [
            Spacer(),
            SizedBox(
              width: 35,
              height: 35,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ]);
  }
}
