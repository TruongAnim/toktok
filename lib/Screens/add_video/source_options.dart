import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Theme/colors.dart';

class SourceOptions extends StatelessWidget {
  final Function galleryTap;
  final Function cameraTap;
  const SourceOptions(
      {super.key, required this.galleryTap, required this.cameraTap});

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/images/camera_preview.jpg',
          fit: BoxFit.fill,
          height: ht,
          width: wt,
        ),
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
          width: wt,
          bottom: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                child: Image.asset(
                  'assets/icons/gallery1.png',
                  width: 65,
                ),
                onTap: () {
                  galleryTap(ImageSource.gallery, context);
                },
              ),
              GestureDetector(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: videoCall,
                  child: Icon(
                    Icons.videocam,
                    color: secondaryColor,
                    size: 30,
                  ),
                ),
                onTap: () {
                  cameraTap(ImageSource.camera, context);
                },
              ),
              Icon(
                Icons.flash_off,
                color: secondaryColor,
              ),
            ],
          ),
        ),
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
              SizedBox(
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
