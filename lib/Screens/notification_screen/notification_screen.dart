import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Locale/locale.dart';
import 'package:toktok/Screens/notification_screen/controllers/notification_controller.dart';
import 'package:toktok/Screens/notification_screen/widgets/messages_tab.dart';
import 'package:toktok/Screens/notification_screen/widgets/notification_tab.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/models/notif.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationController _notificationController;
  @override
  void initState() {
    super.initState();
    _notificationController = Get.find();
    _notificationController.getNotifications();
  }

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
              child: Obx(() {
                print(
                    '_notificationController.notifications ${_notificationController.notifications}');
                return NotificationTab(
                    notification: _notificationController.notifications);
              }),
            ),
            FadedSlideAnimation(
              child: MessagesTab(messages: messages),
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
