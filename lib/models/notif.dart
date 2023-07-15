import 'package:cloud_firestore/cloud_firestore.dart';

class Notif {
  final String id;
  final String uid;
  final String senderId;
  final String videoId;
  final String title;
  final String desc;
  final String type;
  final bool isRead;
  final Timestamp time;

  Notif({
    required this.id,
    required this.uid,
    required this.senderId,
    required this.videoId,
    required this.title,
    required this.desc,
    required this.type,
    required this.isRead,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'senderId': senderId,
      'videoId': videoId,
      'title': title,
      'desc': desc,
      'type': type,
      'isRead': isRead,
      'time': time,
    };
  }

  Map<String, dynamic> toJsonDio() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'senderId': senderId,
      'videoId': videoId,
      'title': title,
      'desc': desc,
      'type': type,
      'isRead': isRead,
      'time': time.millisecondsSinceEpoch,
    };
  }

  static Notif fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return Notif(
      id: snap['id'] as String,
      uid: snap['uid'] as String,
      senderId: snap['senderId'] as String,
      videoId: snap['videoId'] as String,
      title: snap['title'] as String,
      desc: snap['desc'] as String,
      type: snap['type'] as String,
      isRead: snap['isRead'] as bool,
      time: snap['time'] as Timestamp,
    );
  }
}
