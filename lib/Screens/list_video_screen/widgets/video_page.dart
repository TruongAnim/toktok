import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/BottomNavigation/controllers/bottom_navigation_controller.dart';
import 'package:toktok/Components/custom_button.dart';
import 'package:toktok/Components/rotated_image.dart';
import 'package:toktok/Components/score_container.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/Screens/comment/comment_sheet.dart';
import 'package:toktok/Screens/list_video_screen/list_video_screen.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/controllers/auth_controller.dart';
import 'package:toktok/controllers/video_info_controller.dart';
import 'package:toktok/models/video.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final Video video;
  final int? pageIndex;
  final int? currentPageIndex;
  final bool? isPaused;
  final bool? isFollowing;

  const VideoPage(this.video,
      {super.key,
      this.pageIndex,
      this.currentPageIndex,
      this.isPaused,
      this.isFollowing});

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
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl))
          ..initialize().then((value) {
            setState(() {
              _controller.setLooping(true);
              initialized = true;
              _videoInfoController.increaseView(widget.video.id);
            });
          });

    // String video = RandomUtils.getRandomVideo();
    // print(video);
    // _controller = VideoPlayerController.asset(video)
    //   ..initialize().then((value) {
    //     setState(() {
    //       _controller.setLooping(true);
    //       initialized = true;
    //       _videoInfoController.increaseView(widget.video.id);
    //     });
    //   });
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
      resizeToAvoidBottomInset: false,
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
                const SizedBox(height: 15),
                CustomButton(
                    Image.asset(
                      'assets/coin.png',
                      height: 27,
                    ),
                    widget.video.points.toString(),
                    onPressed: () => _videoInfoController.donate(widget.video)),
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
                    _videoInfoController.like(widget.video);
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
                    ),
                  ),
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
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          height: 3)),
                  TextSpan(
                    text: '${widget.video.caption}\n',
                    style: const TextStyle(fontSize: 15),
                  ),
                  TextSpan(
                      text: widget.video.songName,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, height: 1.5)),
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
