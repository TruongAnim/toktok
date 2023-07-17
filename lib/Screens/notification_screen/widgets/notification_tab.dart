import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktok/Screens/notification_screen/controllers/notification_controller.dart';
import 'package:toktok/Screens/notification_screen/widgets/notif_avatar.dart';
import 'package:toktok/Screens/notification_screen/widgets/notif_thumbnail.dart';
import 'package:toktok/Screens/notification_screen/widgets/notif_title.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/models/notif.dart';
import 'package:toktok/utils/common_utils.dart';
import 'package:toktok/utils/time_utils.dart';

class NotificationTab extends StatefulWidget {
  const NotificationTab({super.key});

  @override
  State<NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  late NotificationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find();
    _controller.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: _controller.notifications.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Notif notif = _controller.notifications[index];
          return Stack(
            children: <Widget>[
              ListTile(
                  leading: NotifAvatar(
                      avatar: _controller.getUserProfile(notif.senderId)),
                  title: NotifTitle(
                    name: _controller.getUserName(notif.senderId),
                    title: notif.title,
                  ),
                  subtitle: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: '${notif.desc} ',
                      style: TextStyle(color: lightTextColor),
                    ),
                    TextSpan(
                        text: TimeUtils.getTimeFromMilisecond(notif.time),
                        style:
                            TextStyle(color: lightTextColor.withOpacity(0.15)))
                  ])),
                  trailing: SizedBox(
                    width: 50,
                    child: NotifThumbnail(
                      thumbnail: _controller.getVideoThumnail(notif.videoId),
                    ),
                  ),
                  onTap: () => _controller.onTap(index)),
              Positioned.directional(
                  textDirection: Directionality.of(context),
                  end: 55,
                  bottom: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 13,
                    child: CommonUtils.getIconFromType(notif.type, 18),
                  )),
            ],
          );
        },
      ),
    );
  }
}
