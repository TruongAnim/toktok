import 'package:flutter/material.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/Theme/colors.dart';
import 'package:toktok/models/notif.dart';

class NotificationTab extends StatelessWidget {
  const NotificationTab({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final List<Notif> notification;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: notification.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Stack(children: <Widget>[
            ListTile(
                leading: CircleAvatar(
                    backgroundImage: AssetImage(notification[index].image)),
                title: Text(
                  notification[index].name,
                  style: TextStyle(color: secondaryColor),
                ),
                subtitle: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: notification[index].desc! + ' ',
                    style: TextStyle(color: lightTextColor),
                  ),
                  TextSpan(
                      text: notification[index].time,
                      style: TextStyle(color: lightTextColor.withOpacity(0.15)))
                ])),
                trailing: Container(
                  width: 50,
                  //height: 45,
                  child: notification[index].icon == Icons.add
                      ? CircleAvatar(
                          radius: 25.0,
                          backgroundImage:
                              AssetImage('assets/images/user.webp'),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: AssetImage(
                                      notification[index].notifImage),
                                  fit: BoxFit.fill))),
                ),
                onTap: () {
                  // FirebaseMessagingService.instance.sendNotification();
                  Navigator.pushNamed(context, PageRoutes.userProfilePage);
                }),
            Positioned.directional(
                textDirection: Directionality.of(context),
                end: 55,
                bottom: 10,
                child: CircleAvatar(
                  backgroundColor: mainColor,
                  child: Icon(
                    notification[index].icon,
                    color: Colors.white,
                    size: 10,
                  ),
                  radius: 10,
                )),
          ]);
        });
  }
}
