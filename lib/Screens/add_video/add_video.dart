import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/Screens/add_video/new_source_options.dart';
import 'package:toktok/Screens/add_video/source_options.dart';
import 'package:toktok/Theme/colors.dart';

class AddVideo extends StatefulWidget {
  @override
  _AddVideoState createState() => _AddVideoState();
}

class _AddVideoState extends State<AddVideo> {
  void _pickVideo(ImageSource source, BuildContext context) async {
    final video = await ImagePicker().pickVideo(
      source: source,
    );
    if (video != null) {
      Get.toNamed(
        PageRoutes.addVideoFilterPage,
        arguments: {
          'videoFile': File(video.path),
          'videoPath': video.path,
        },
      );
    }
  }

  void fromGallery() {
    _pickVideo(ImageSource.gallery, context);
  }

  void fromCamera() {
    _pickVideo(ImageSource.camera, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadedSlideAnimation(
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
          // child: SourceOptions(
          //   galleryTap: _pickVideo,
          //   cameraTap: _pickVideo,
          // )),
          child: NewSourceOptions(
            galleryTap: fromGallery,
            cameraTap: fromCamera,
          )),
    );
  }
}
