import 'package:flutter/material.dart';

class CommonUtils {
  static IconData getIconFromType(String type) {
    if (type == 'comment') {
      return Icons.comment;
    }
    if (type == 'favourite') {
      return Icons.favorite;
    }
    if (type == 'post_video') {
      return Icons.ondemand_video_sharp;
    }
    return Icons.error;
  }
}
