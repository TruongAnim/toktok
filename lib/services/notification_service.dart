import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toktok/models/notif.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  static NotificationService get instance => _instance;
  NotificationService._();

  Future<List<Notif>> getNotifications(String uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('notifications')
        .where('uid', isEqualTo: uid)
        .get();
    return querySnapshot.docs.map((e) => Notif.fromSnapshot(e)).toList();
  }

  Future<void> addNotification(Notif notif) async {
    await FirebaseFirestore.instance
        .collection('notifications')
        .add(notif.toJson());
  }
}
