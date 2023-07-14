import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:toktok/Components/tab_grid.dart';
import 'package:toktok/models/video.dart';

class MorePage extends StatelessWidget {
  final String title;
  final List<Video> videos;

  MorePage({super.key, required this.title, required this.videos});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: FadedSlideAnimation(
            beginOffset: const Offset(0.3, 0.3),
            endOffset: const Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
            child: TabGrid(
              videos,
              viewIcon: Icons.remove_red_eye,
              showView: true,
            ),
          )),
    );
  }
}
