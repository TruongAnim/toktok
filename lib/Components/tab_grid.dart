import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numeral/numeral.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/models/video.dart';

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
        physics: const BouncingScrollPhysics(),
        itemCount: list.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 2.5,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Get.toNamed(PageRoutes.followingTabPage, arguments: {
              'videos': list,
              'isFollowing': false,
              'variable': index,
            }),
            child: FadedScaleAnimation(
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(list[index].thumbnail),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(8),
                ),
                Positioned(
                  child: Container(
                    margin: const EdgeInsets.only(top: 8, left: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Wrap(
                      children: <Widget>[
                        showView
                            ? Icon(
                                viewIcon,
                                color: secondaryColor,
                                size: 20,
                              )
                            : SizedBox.shrink(),
                        showView
                            ? Text(
                                ' ${Numeral(list[index].viewCount).format(fractionDigits: 1)}',
                                style: TextStyle(fontSize: 16),
                              )
                            : const SizedBox.shrink(),
                        icon != null
                            ? Icon(
                                icon,
                                color: Colors.red,
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                )
              ]),
            ),
          );
        });
  }
}
