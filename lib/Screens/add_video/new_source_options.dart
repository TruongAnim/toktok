import 'package:flutter/material.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Screens/add_video/animated_glass_card.dart';
import 'package:toktok/Theme/colors.dart';

class NewSourceOptions extends StatelessWidget {
  final VoidCallback galleryTap;
  final VoidCallback cameraTap;
  const NewSourceOptions(
      {super.key, required this.galleryTap, required this.cameraTap});

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        // Image.asset(
        //   'assets/images/camera_preview.jpg',
        //   fit: BoxFit.fill,
        //   height: ht,
        //   width: wt,
        // ),
        Positioned(
          top: 28,
          left: 4,
          child: IconButton(
            icon: Icon(
              Icons.close,
              color: secondaryColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Positioned(
            child: Center(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            AnimatedGlassCard(
                label: 'Gallery',
                icon: Icons.video_collection,
                onTap: galleryTap),
            AnimatedGlassCard(
                label: 'Camera', icon: Icons.video_call, onTap: cameraTap)
          ]),
        )),
        Positioned(
          width: wt,
          bottom: 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.keyboard_arrow_up,
                color: secondaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                AppLocalizations.of(context)!.swipeUpForGallery!,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
