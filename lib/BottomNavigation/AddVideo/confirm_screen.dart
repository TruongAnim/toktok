import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/controllers/upload_controller.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen(
      {super.key, required this.videoFile, required this.videoPath});
  final File videoFile;
  final String videoPath;

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController videoPlayerController;
  TextEditingController songController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  UploadController uploadController = Get.find();

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.file(widget.videoFile);
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setVolume(1);
    videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: VideoPlayer(videoPlayerController),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              Container(
                margin: const EdgeInsets.all(15),
                child: TextField(
                  controller: songController,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: TextField(
                  controller: captionController,
                ),
              ),
              Obx(
                () => uploadController.isUploading.value
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          uploadController.uploadVideo(songController.text,
                              captionController.text, widget.videoPath);
                        },
                        child: const Text('Share now'),
                      ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
