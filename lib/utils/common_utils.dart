import 'package:flutter/material.dart';
import 'package:toktok/Theme/colors.dart';

class CommonUtils {
  static Icon getIconFromType(String type, double size) {
    if (type == 'comment') {
      return Icon(
        Icons.add_comment_sharp,
        size: size,
        color: Colors.orange[400],
      );
    }
    if (type == 'favourite') {
      return Icon(
        Icons.favorite,
        size: size,
        color: Colors.red,
      );
    }
    if (type == 'new_post') {
      return Icon(
        Icons.add_photo_alternate_outlined,
        size: size,
        color: mainColor,
      );
    }
    return Icon(
      Icons.error,
      size: size,
      color: Colors.red,
    );
  }
}
