import 'package:flutter/material.dart';
import 'package:toktok/Routes/routes.dart';

class RotatedImage extends StatefulWidget {
  final String image;

  RotatedImage(this.image);

  @override
  _RotatedImageState createState() => _RotatedImageState();
}

class _RotatedImageState extends State<RotatedImage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3, milliseconds: 500),
    )..addListener(() => setState(() {}));
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    if (widget.isPlaying) {
//      animationController.repeat();
//    } else {
//      animationController.stop();
//    }
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, PageRoutes.audio);
      },
      child: RotationTransition(
        turns: animation,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/disk.png',
              scale: 2.2,
            ),
            Positioned.directional(
              textDirection: Directionality.of(context),
              start: 7.5,
              top: 7.5,
              child: SizedBox(
                height: 30,
                width: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
