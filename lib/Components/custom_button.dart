import 'package:flutter/material.dart';
import 'package:toktok/Theme/colors.dart';

class CustomButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final Function? onPressed;
  final double padding;

  CustomButton(this.icon, this.text,
      {super.key, this.onPressed, this.padding = 12});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: transparentColor,
      padding: EdgeInsets.symmetric(vertical: padding),
      onPressed: onPressed as void Function()?,
      child: Column(
        children: <Widget>[
          icon,
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: secondaryColor),
          )
        ],
      ),
    );
  }
}
