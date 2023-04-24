import 'package:flutter/material.dart';
import 'package:toktok/Components/thumb_tile.dart';
import 'package:toktok/models/video.dart';

class ThumbList extends StatelessWidget {
  final List<Video> videos;

  ThumbList(this.videos);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: 8.0),
      height: screenWidth / 3,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: videos.length,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ThumbTile(videos, index);
          }),
    );
  }
}
