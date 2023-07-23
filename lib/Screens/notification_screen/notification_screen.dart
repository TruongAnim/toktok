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
              labelStyle: Theme.of(context).textTheme.titleMedium,
              unselectedLabelColor: disabledTextColor,
              tabs: <Widget>[
                Tab(text: locale.notifications),
                Tab(text: locale.messages),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 56.0),
          child: TabBarView(
            children: <Widget>[
              FadedSlideAnimation(
                beginOffset: const Offset(0, 0.3),
                endOffset: const Offset(0, 0),
                slideCurve: Curves.linearToEaseOut,
                child: const NotificationTab(),
              ),
              FadedSlideAnimation(
                beginOffset: const Offset(0, 0.3),
                endOffset: const Offset(0, 0),
                slideCurve: Curves.linearToEaseOut,
                child: const MessagesTab(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
