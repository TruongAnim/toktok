import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/Screens/list_video_screen/list_video_screen.dart';
import 'package:toktok/models/video.dart';

class ThumbTile extends StatelessWidget {
  final List<Video> videos;
  final int index;

  ThumbTile(this.videos, this.index);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
        child: FadedScaleAnimation(
          child: Container(
            margin: EdgeInsets.only(left: 8.0),
            height: screenWidth / 3,
            width: screenWidth / 4.25,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(videos[index].thumbnail),
                  fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        onTap: () => Get.toNamed(PageRoutes.followingTabPage, arguments: {
              'videos': videos,
              'isFollowing': false,
              'variable': index,
            }));
  }
}
