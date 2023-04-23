import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:toktok/BottomNavigation/Home/following_tab.dart';
import 'package:toktok/BottomNavigation/Home/home_page.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/models/video.dart';
import 'package:toktok/utils/random_utils.dart';

class TabGrid extends StatelessWidget {
  final List<Video> list;
  final IconData? icon;
  final Function? onTap;
  final IconData? viewIcon;
  final bool showView;

  const TabGrid(this.list,
      {super.key,
      this.icon,
      this.onTap,
      this.viewIcon,
      required this.showView});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 2.5,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FollowingTabPage(list, false, variable: 1))),
            child: FadedScaleAnimation(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(list[index].thumbnail),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      viewIcon,
                      color: secondaryColor,
                      size: 15,
                    ),
                    showView
                        ? Text(' ' + RandomUtils.getRandomView())
                        : SizedBox.shrink(),
                    Spacer(),
                    Icon(
                      icon,
                      color: mainColor,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
