import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Components/continue_button.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/models/audio_details.dart';
import 'package:video_player/video_player.dart';

class AddVideoFilter extends StatefulWidget {
  @override
  _AddVideoFilterState createState() => _AddVideoFilterState();
}

class _AddVideoFilterState extends State<AddVideoFilter> {
  List<String> images = [
    'assets/images/video 2.png',
    'assets/images/video 2.png',
    'assets/images/video 2.png',
    'assets/images/video 2.png',
    'assets/images/video 2.png',
    'assets/images/video 2.png',
    'assets/images/video 2.png',
    'assets/images/video 2.png',
  ];

  List<Color?> color = [
    Color(0xff7c94b6),
    Colors.orange[200],
    Colors.grey[300],
    Colors.grey[400],
    Colors.blueAccent[400],
    Colors.blueGrey[400],
    Colors.grey[300],
    Colors.blueGrey[400],
  ];

  List<BlendMode> blendMode = [
    BlendMode.dstATop,
    BlendMode.dst,
    BlendMode.hue,
    BlendMode.hardLight,
    BlendMode.modulate,
    BlendMode.dstATop,
    BlendMode.hardLight,
    BlendMode.darken,
  ];
  Map<String, dynamic> data = {};

  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = Get.arguments;
    videoPlayerController = VideoPlayerController.file(data['videoFile'])
      ..initialize().then((value) {
        setState(() {
          videoPlayerController.setLooping(true);
          videoPlayerController.play();
          videoPlayerController.setVolume(1);
        });
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: VideoPlayer(videoPlayerController),
        ),
        AppBar(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 72,
            margin: EdgeInsets.only(bottom: 78.0, left: 12.0, right: 12),
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return FadedScaleAnimation(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  color[index]!, blendMode[index]),
                              image: AssetImage(images[index]),
                              fit: BoxFit.cover)),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      height: 72,
                      width: 72,
                      //child: Image.asset(images[index], fit: BoxFit.fill,),
                    ),
                  );
                }),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    alignment: Alignment.centerLeft,
                    child: CustomButton(
                      color: transparentColor,
                      icon: Icon(
                        Icons.music_note,
                        color: secondaryColor,
                      ),
                      text: data['music'] != null
                          ? data['music'].toString()
                          : AppLocalizations.of(context)!.addMusic,
                      onPressed: () async {
                        AudioDetails? result =
                            await Get.toNamed(PageRoutes.addMusic)
                                as AudioDetails?;
                        data['music'] = result;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                Spacer(),
                CustomButton(
                    text: AppLocalizations.of(context)!.next,
                    onPressed: () {
                      videoPlayerController.pause();

                      Get.toNamed(PageRoutes.postInfoPage, arguments: data);
                    })
              ],
            ),
          ),
        ),
      ],
    );
  }
}
