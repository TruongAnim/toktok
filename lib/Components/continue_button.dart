import 'package:flutter/material.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/Theme/style.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Function? onPressed;
  final Color? borderColor;
  final Color? color;
  final TextStyle? style;
  final Widget? icon;
  final Color? textColor;

  CustomButton({
    this.text,
    this.onPressed,
    this.borderColor,
    this.color,
    this.style,
    this.icon,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          backgroundColor: color ?? mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
            side: BorderSide(color: borderColor ?? Colors.transparent),
          ),
        ),
        icon: icon ?? SizedBox.shrink(),
        onPressed: onPressed as void Function()?,
        label: SizedBox(
          child: Text(
            text ?? locale!.continueText!,
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style ??
                Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: textColor ?? secondaryColor),
          ),
        ),
      ),
    );
  }
}
