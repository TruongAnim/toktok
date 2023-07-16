import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/controllers/upload_controller.dart';

class PostThumbTile extends StatefulWidget {
  final Uint8List media;
  final int index;
  const PostThumbTile({super.key, required this.media, required this.index});
  @override
  _PostThumbTileState createState() => _PostThumbTileState();
}

class _PostThumbTileState extends State<PostThumbTile> {
  final UploadController _uploadController = Get.find();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Obx(
      () {
        bool check = _uploadController.thumbnailIndex.value == widget.index;
        double opacity = check ? 0.4 : 1;
        return Stack(
          children: <Widget>[
            Positioned(
              child: GestureDetector(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(opacity), BlendMode.dstATop),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      height: screenWidth / 3,
                      width: screenWidth / 4.25,
                      decoration: BoxDecoration(
                        /*image: DecorationImage(
                          image: AssetImage(widget.mediaListData),
                          fit: BoxFit.fill),*/
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Image.memory(
                        widget.media,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  onTap: () {
                    _uploadController.thumbnailIndex.value = widget.index;
                  }),
            ),
            Positioned(
              top: screenWidth / 8,
              left: screenWidth / 10,
              child: GestureDetector(
                onTap: () {},
                child: check
                    ? CircleAvatar(
                        radius: 15,
                        backgroundColor: mainColor,
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                        ))
                    : const SizedBox(),
              ),
            ),
          ],
        );
      },
    );
  }
}
