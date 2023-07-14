import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:toktok/Screens/home_screen/comment_sheet.dart';
import 'package:toktok/BottomNavigation/controllers/bottom_navigation_controller.dart';
import 'package:toktok/Components/custom_button.dart';
import 'package:toktok/Components/rotated_image.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/controllers/auth_controller.dart';
import 'package:toktok/controllers/video_info_controller.dart';
import 'package:toktok/models/video.dart';
import 'package:toktok/utils/random_utils.dart';
import 'package:video_player/video_player.dart';
import 'package:toktok/Components/score_container.dart';

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class FollowingTabPage extends StatelessWidget {
  final List<Video> videos;
  final bool isFollowing;

  final int? variable;

  FollowingTabPage(this.videos, this.isFollowing, {this.variable});

  @override
  Widget build(BuildContext context) {
    return FollowingTabBody(videos, isFollowing, variable);
  }
}

class FollowingTabBody extends StatefulWidget {
  final List<Video> videos;

  final bool isFollowing;
  final int? variable;

  FollowingTabBody(this.videos, this.isFollowing, this.variable);

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

class VideoPage extends StatefulWidget {
  final Video video;
  final int? pageIndex;
  final int? currentPageIndex;
  final bool? isPaused;
  final bool? isFollowing;

  VideoPage(this.video,
      {this.pageIndex, this.currentPageIndex, this.isPaused, this.isFollowing});

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with RouteAware {
  late VideoPlayerController _controller;
  late VideoInfoController _videoInfoController;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    _videoInfoController = Get.find();
    // _controller = VideoPlayerController.network(widget.video.videoUrl)
    //   ..initialize().then((value) {
    //     setState(() {
    //       _controller.setLooping(true);
    //       initialized = true;
    //     });
    //   });
    String video = RandomUtils.getRandomVideo();
    print(video);
    _controller = VideoPlayerController.asset(video)
      ..initialize().then((value) {
        setState(() {
          _controller.setLooping(true);
          initialized = true;
        });
      });
  }

  @override
  void didPopNext() {
    print("mylog didPopNext");
    _controller.play();
    super.didPopNext();
  }

  @override
  void didPushNext() {
    print("mylog didPushNext");
    _controller.pause();
    super.didPushNext();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(
        this, ModalRoute.of(context) as PageRoute<dynamic>); //Subscribe it here
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pageIndex == widget.currentPageIndex &&
        !widget.isPaused! &&
        initialized) {
      _controller.play();
    } else {
      _controller.pause();
    }
    var locale = AppLocalizations.of(context)!;
//    if (_controller.value.position == _controller.value.duration) {
//      setState(() {
//      });
//    }
// if (widget.pageIndex == 2) _controller.pause();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            },
            child: _controller.value.isInitialized
                ? VideoPlayer(_controller)
                : const SizedBox.shrink(),
          ),
          Positioned.directional(
            textDirection: Directionality.of(context),
            end: -10.0,
            bottom: 80.0,
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    _controller.pause();
                    if (widget.video.uid == firebaseAuth.currentUser?.uid) {
                      Get.find<BottomNavigationController>().changeTab(4);
                    } else {
                      Get.toNamed(PageRoutes.userProfilePage,
                          arguments: {'uid': widget.video.uid});
                    }
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                          backgroundImage:
                              NetworkImage(widget.video.profilePhoto)),
                      PositionedDirectional(
                        bottom: -10,
                        start: 12,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: mainColor,
                          child: Icon(
                            Icons.add,
                            size: 12,
                            color: secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  ImageIcon(
                    const AssetImage('assets/icons/ic_views.png'),
                    color: secondaryColor,
                  ),
                  widget.video.shareCount.toString(),
                ),
                CustomButton(
                    ImageIcon(
                      const AssetImage('assets/icons/ic_comment.png'),
                      color: secondaryColor,
                    ),
                    widget.video.commentCount.toString(), onPressed: () {
                  commentSheet(context, widget.video.id);
                }),
                CustomButton(
                  Icon(
                    widget.video.likes
                            .contains(AuthController.instance.user.uid)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: widget.video.likes
                            .contains(AuthController.instance.user.uid)
                        ? Colors.red
                        : secondaryColor,
                  ),
                  widget.video.likes.length.toString(),
                  onPressed: () {
                    _videoInfoController.like(widget.video.id);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: RotatedImage(widget.video.albumPhoto),
                ),
              ],
            ),
          ),
          widget.isFollowing!
              ? Positioned.directional(
                  textDirection: Directionality.of(context),
                  end: 27.0,
                  bottom: 320.0,
                  child: CircleAvatar(
                      backgroundColor: mainColor,
                      radius: 8,
                      child: Icon(
                        Icons.add,
                        color: secondaryColor,
                        size: 12.0,
                      )),
                )
              : const SizedBox.shrink(),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.only(bottom: 60.0),
                child: LinearProgressIndicator(
                    //minHeight: 1,
                    )),
          ),
          Positioned.directional(
            textDirection: Directionality.of(context),
            start: 12.0,
            bottom: 72.0,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, PageRoutes.addMusic);
              },
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: '@${widget.video.username}\n',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          height: 3)),
                  TextSpan(
                    text: '${widget.video.caption}\n',
                    style: TextStyle(fontSize: 15),
                  ),
                  TextSpan(
                      text: '${widget.video.songName}',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, height: 1.5)),
                  TextSpan(
                      text: '  ${locale.seeMore}',
                      style: TextStyle(
                          color: secondaryColor.withOpacity(0.5),
                          fontStyle: FontStyle.italic))
                ]),
              ),
            ),
          ),
          const PositionedDirectional(end: 20, top: 34, child: CoinContainer())
        ],
      ),
    );
  }
}
