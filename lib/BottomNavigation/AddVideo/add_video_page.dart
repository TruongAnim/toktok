import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toktok/BottomNavigation/AddVideo/confirm_screen.dart';
import 'package:toktok/Routes/routes.dart';

class AddVideoPage extends StatelessWidget {
  const AddVideoPage({super.key});

  void _pickVideo(ImageSource source, BuildContext context) async {
    final video = await ImagePicker().pickVideo(
      source: source,
    );
    if (video != null) {
      Get.toNamed(
        PageRoutes.addVideoFilterPage,
        arguments: {
          'videoFile': File(video.path),
          'videoPath': video.path,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  children: [
                    SimpleDialogOption(
                      onPressed: () {
                        _pickVideo(ImageSource.gallery, context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(children: const [
                          Icon(Icons.image),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(fontSize: 18),
                          )
                        ]),
                      ),
                    ),
                    SimpleDialogOption(
                        onPressed: () {
                          _pickVideo(ImageSource.camera, context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(children: const [
                            Icon(Icons.camera),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Camera',
                              style: TextStyle(fontSize: 18),
                            )
                          ]),
                        )),
                    SimpleDialogOption(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(children: const [
                            Icon(Icons.cancel),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Cancel',
                              style: TextStyle(fontSize: 18),
                            )
                          ]),
                        ))
                  ],
                );
              },
            );
          },
          child: const Text('Add video'),
        ),
      ),
    );
  }
}
