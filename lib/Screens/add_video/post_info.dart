import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Components/continue_button.dart';
import 'package:toktok/Components/entry_field.dart';
import 'package:toktok/Components/post_thumb_list.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/controllers/auth_controller.dart';
import 'package:toktok/controllers/upload_controller.dart';

class PostInfo extends StatefulWidget {
  @override
  _PostInfoState createState() => _PostInfoState();
}

class _PostInfoState extends State<PostInfo> {
  var icon = Icons.check_box_outline_blank;
  bool isSwitched1 = false;
  bool isSwitched2 = false;

  final List<PostThumbList> thumbLists = [
    PostThumbList(dance),
  ];
  static List<String> dance = [
    'assets/thumbnails/dance/Layer 951.png',
    'assets/thumbnails/dance/Layer 952.png',
    'assets/thumbnails/dance/Layer 953.png',
    'assets/thumbnails/dance/Layer 954.png',
    'assets/thumbnails/dance/Layer 951.png',
    'assets/thumbnails/dance/Layer 952.png',
    'assets/thumbnails/dance/Layer 953.png',
    'assets/thumbnails/dance/Layer 954.png',
  ];
  Map<String, dynamic> data = {};
  late TextEditingController _titleController;
  late UploadController _uploadController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = Get.arguments;
    _titleController = TextEditingController();
    _uploadController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.post!),
        centerTitle: true,
      ),
      body: Stack(alignment: Alignment.center, children: [
        FadedSlideAnimation(
          beginOffset: const Offset(0, 0.3),
          endOffset: const Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  MediaQuery.of(context).padding.vertical,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  EntryField(
                    controller: _titleController,
                    prefix: FadedScaleAnimation(
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(AuthController.instance.profileTemp),
                      ),
                    ),
                    label:
                        '    ' + AppLocalizations.of(context)!.describeVideo!,
                  ),
                  const Spacer(),
                  Text(
                    AppLocalizations.of(context)!.selectCover! + '\n',
                    style: TextStyle(color: secondaryColor, fontSize: 18),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: thumbLists.length,
                      itemBuilder: (context, index) {
                        return thumbLists[index];
                      }),
                  const SizedBox(height: 12.0),
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.commentOff!,
                      style: TextStyle(color: secondaryColor),
                    ),
                    trailing: Switch(
                      value: isSwitched1,
                      onChanged: (value) {
                        setState(() {
                          isSwitched1 = value;
                          //print(isSwitched1);
                        });
                      },
                      inactiveThumbColor: disabledTextColor,
                      inactiveTrackColor: darkColor,
                      activeTrackColor: darkColor,
                      activeColor: mainColor,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.saveToGallery!,
                      style: TextStyle(color: secondaryColor),
                    ),
                    trailing: Switch(
                      value: isSwitched2,
                      onChanged: (value) {
                        setState(() {
                          isSwitched2 = value;
                          //print(isSwitched2);
                        });
                      },
                      inactiveThumbColor: disabledTextColor,
                      inactiveTrackColor: darkColor,
                      activeTrackColor: darkColor,
                      activeColor: mainColor,
                    ),
                  ),
                  const Spacer(),
                  CustomButton(
                    text: AppLocalizations.of(context)!.postVideo,
                    onPressed: () {
                      String songName = data['music'] != null
                          ? data['music'].toString()
                          : 'Original music';
                      String caption = _titleController.text.trim().isNotEmpty
                          ? _titleController.text.trim()
                          : 'Title';
                      String videoPath = data['videoPath'];
                      _uploadController.uploadVideo(
                          songName, caption, videoPath);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        Obx(() => _uploadController.isUploading.value
            ? const Opacity(
                opacity: 0.8,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              )
            : Container()),
        Obx(() {
          if (_uploadController.isUploading.value) {
            return Container(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        })
      ]),
    );
  }
}
