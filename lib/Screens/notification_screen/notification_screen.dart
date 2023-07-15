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
    print(
        '_notificationController.notifications ${_notificationController.notifications}');
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<Notif> notification = [
      // Notif(
      //     "Emili Williamson",
      //     locale.likedYourVideo,
      //     "5 " + locale.minAgo!,
      //     "assets/user/user1.png",
      //     "assets/thumbnails/dance/Layer 951.png",
      //     Icons.favorite),
      // Notif(
      //     "Kesha Taylor",
      //     locale.commentedOnYour,
      //     "5 " + locale.minAgo!,
      //     "assets/user/user2.png",
      //     "assets/thumbnails/dance/Layer 952.png",
      //     Icons.message),
      // Notif(
      //     "Ling Tong",
      //     locale.commentedOnYour,
      //     "5 " + locale.minAgo!,
      //     "assets/user/user3.png",
      //     "assets/thumbnails/food/Layer 783.png",
      //     Icons.message),
      // Notif(
      //     "Linda Johnson",
      //     locale.likedYourVideo,
      //     "5 " + locale.minAgo!,
      //     "assets/user/user4.png",
      //     "assets/thumbnails/food/Layer 786.png",
      //     Icons.favorite),
      // Notif("George Smith", locale.startedFollowing, "5 " + locale.minAgo!,
      //     "assets/user/user1.png", "assets/images/user.webp", Icons.add),
      // Notif(
      //     "Emili Williamson",
      //     locale.likedYourVideo,
      //     "5 " + locale.minAgo!,
      //     "assets/user/user1.png",
      //     "assets/thumbnails/dance/Layer 951.png",
      //     Icons.favorite),
      // Notif(
      //     "Kesha Taylor",
      //     locale.commentedOnYour,
      //     "5 " + locale.minAgo!,
      //     "assets/user/user2.png",
      //     "assets/thumbnails/dance/Layer 952.png",
      //     Icons.message),
      // Notif(
      //     "Ling Tong",
      //     locale.commentedOnYour,
      //     "5 " + locale.minAgo!,
      //     "assets/user/user3.png",
      //     "assets/thumbnails/food/Layer 783.png",
      //     Icons.message),
    ];

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
              child: NotificationTab(notification: notification),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
            FadedSlideAnimation(
              child:
                  MessagesTab(notification: notification, messages: messages),
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
