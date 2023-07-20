import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:toktok/Screens/list_video_screen/widgets/video_page.dart';
import 'package:toktok/models/video.dart';

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class ListVideoScreen extends StatelessWidget {
  const ListVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = Get.arguments;
    return FollowingTabBody(
        arguments['videos'], arguments['isFollowing'], arguments['variable']);
  }
}

class FollowingTabBody extends StatefulWidget {
  final List<Video> videos;
  final bool isFollowing;
  final int? variable;

  const FollowingTabBody(this.videos, this.isFollowing, this.variable,
      {super.key});

  @override
  _FollowingTabBodyState createState() => _FollowingTabBodyState();
}

class _FollowingTabBodyState extends State<FollowingTabBody> {
  PreloadPageController? _pageController;
  int current = 0;
  bool isOnPageTurning = false;

  void scrollListener() {
    if (isOnPageTurning &&
        _pageController!.page == _pageController!.page!.roundToDouble()) {
      setState(() {
        current = _pageController!.page!.toInt();
        isOnPageTurning = false;
      });
    } else if (!isOnPageTurning &&
        current.toDouble() != _pageController!.page) {
      if ((current.toDouble() - _pageController!.page!).abs() > 0.1) {
        setState(() {
          isOnPageTurning = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PreloadPageController(
      initialPage: widget.variable ?? 0,
    );
    _pageController!.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return PreloadPageView.builder(
      // allowImplicitScrolling: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: _pageController,
      itemBuilder: (context, position) {
        return VideoPage(
          widget.videos[position],
          pageIndex: position,
          currentPageIndex: current,
          isPaused: isOnPageTurning,
          isFollowing: widget.isFollowing,
        );
      },
      onPageChanged: widget.variable == null
          ? (i) {
              print('mylog onPageChanged $i');
            }
          : null,
      itemCount: widget.videos.length,
    );
  }
}
