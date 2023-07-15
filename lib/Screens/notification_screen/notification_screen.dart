import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Screens/notification_screen/widgets/messages_tab.dart';
import 'package:toktok/Screens/notification_screen/widgets/notification_tab.dart';
import 'package:toktok/Theme/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    List<String?> messages = [
      locale.heyILikeYourVideos,
      locale.yesIUse,
      locale.noWorries,
      locale.ohThank,
      locale.alreadyLikedIt,
      locale.noWorries,
      locale.ohThank,
      locale.alreadyLikedIt,
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              indicator: BoxDecoration(color: transparentColor),
              isScrollable: true,
              labelColor: mainColor,
              labelStyle: Theme.of(context).textTheme.headline6,
              unselectedLabelColor: disabledTextColor,
              tabs: <Widget>[
                Tab(text: locale.notifications),
                Tab(text: locale.messages),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            FadedSlideAnimation(
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
              child: NotificationTab(),
            ),
            FadedSlideAnimation(
              child: MessagesTab(),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
          ],
        ),
      ),
    );
  }
}
