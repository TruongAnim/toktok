import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Routes/routes.dart';
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

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FadedSlideAnimation(
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/camera_preview.jpg',
              fit: BoxFit.fill,
              height: ht,
              width: wt,
            ),
            Positioned(
              top: 28,
              left: 4,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: secondaryColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Positioned(
              width: wt,
              bottom: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    child: Image.asset(
                      'assets/icons/gallery1.png',
                      width: 65,
                    ),
                    onTap: () {
                      _pickVideo(ImageSource.gallery, context);
                    },
                  ),
                  GestureDetector(
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: videoCall,
                      child: Icon(
                        Icons.videocam,
                        color: secondaryColor,
                        size: 30,
                      ),
                    ),
                    onTap: () {
                      _pickVideo(ImageSource.camera, context);
                    },
                  ),
                  Icon(
                    Icons.flash_off,
                    color: secondaryColor,
                  ),
                ],
              ),
            ),
            Positioned(
              width: wt,
              bottom: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.keyboard_arrow_up,
                    color: secondaryColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.swipeUpForGallery!,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
