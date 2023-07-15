import 'package:flutter/material.dart';

class CommonUtils {
  static IconData getIconFromType(String type) {
    if (type == 'comment') {
      return Icons.add_comment_sharp;
    }
    if (type == 'favourite') {
      return Icons.favorite;
    }
    if (type == 'new_post') {
      return Icons.add_photo_alternate_outlined;
    }
    return Icons.error;
  }
}
