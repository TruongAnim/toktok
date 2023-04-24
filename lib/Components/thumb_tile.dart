import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:toktok/BottomNavigation/Home/following_tab.dart';
import 'package:toktok/BottomNavigation/Home/home_page.dart';

class ThumbTile extends StatelessWidget {
  final String mediaListData;

  ThumbTile(this.mediaListData);

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
                image: NetworkImage(mediaListData), fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Container() // FollowingTabPage(
            //   videos2 + videos1,
            //   imagesInDisc2 + imagesInDisc1,
            //   false,
            //   variable: 1,
            // ),
            ),
      ),
    );
  }
}
