import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Components/post_thumb_tile.dart';
import 'package:toktok/controllers/upload_controller.dart';

class PostThumbList extends StatelessWidget {
  PostThumbList({super.key});
  final UploadController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Obx(
      () => SizedBox(
        height: screenWidth / 3,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _controller.thumbnails.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return PostThumbTile(
                  media: _controller.thumbnails[index], index: index);
            }),
      ),
    );
  }
}
