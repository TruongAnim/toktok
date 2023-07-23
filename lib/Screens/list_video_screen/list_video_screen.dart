import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:toktok/Screens/list_video_screen/controllers/video_provider_controller.dart';
import 'package:toktok/Screens/list_video_screen/widgets/video_page.dart';
import 'package:toktok/models/video.dart';

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class ListVideoScreen extends StatefulWidget {
  const ListVideoScreen({super.key});

  @override
  State<ListVideoScreen> createState() => _ListVideoScreenState();
}

class _ListVideoScreenState extends State<ListVideoScreen> {
  late VideoProviderController _controller;
  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    _controller = Get.find();
    _controller.updateVideoIds(
        (arguments['videos'] as List<Video>).map((e) => e.id).toList());
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = Get.arguments;
    return Obx(
      () {
        if (_controller.videos.isEmpty) {
          return Container();
        }
        return ListVideoBody(_controller.videos, arguments['isFollowing'],
            arguments['variable']);
      },
    );
  }
}

class ListVideoBody extends StatefulWidget {
  final List<Video> videos;
  final bool isFollowing;
  final int? variable;

  const ListVideoBody(this.videos, this.isFollowing, this.variable,
      {super.key});

  @override
  _ListVideoBodyState createState() => _ListVideoBodyState();
}

class _ListVideoBodyState extends State<ListVideoBody> {
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
