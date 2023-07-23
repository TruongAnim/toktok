import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:toktok/Auth/login_navigator.dart';
import 'package:toktok/Components/continue_button.dart';
import 'package:toktok/Components/entry_field.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Theme/colors.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginBody();
  }
}

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: transparentColor),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: const EdgeInsets.all(16.0),
      child: FadedSlideAnimation(
        beginOffset: const Offset(0, 0.3),
        endOffset: const Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.youWillNeed!,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: secondaryColor),
            ),
            const Spacer(),
            EntryField(
              label: AppLocalizations.of(context)!.enterPhone,
            ),
            CustomButton(
              onPressed: () =>
                  Navigator.pushNamed(context, LoginRoutes.registration),
            ),
            const Spacer(flex: 8),
            Text(
              AppLocalizations.of(context)!.orContinueWith!,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            CustomButton(
              icon: Image.asset(
                'assets/icons/ic_fb.png',
                height: 20,
              ),
              text: '   ${AppLocalizations.of(context)!.facebookAccount}',
              color: fbColor,
              onPressed: () =>
                  Navigator.pushNamed(context, LoginRoutes.socialLogin),
            ),
            CustomButton(
              icon: Image.asset(
                'assets/icons/ic_ggl.png',
                height: 20,
              ),
              text: '   ${AppLocalizations.of(context)!.googleAccount}',
              color: secondaryColor,
              textColor: darkColor,
              onPressed: () =>
                  Navigator.pushNamed(context, LoginRoutes.socialLogin),
            ),
          ],
        ),
      ),
    );
  }
}
