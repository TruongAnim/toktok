import 'package:cloud_firestore/cloud_firestore.dart';

class Notif {
  final String uid;
  final String senderId;
  final String videoId;
  final String title;
  final String desc;
  final String type;
  final Timestamp time;

  Notif({
    required this.uid,
    required this.senderId,
    required this.videoId,
    required this.title,
    required this.desc,
    required this.type,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'senderId': senderId,
      'videoId': videoId,
      'title': title,
      'desc': desc,
      'type': type,
      'time': time,
    };
  }

  static Notif fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return Notif(
      uid: snap['uid'] as String,
      senderId: snap['senderId'] as String,
      videoId: snap['videoId'] as String,
      title: snap['title'] as String,
      desc: snap['desc'] as String,
      type: snap['type'] as String,
      time: snap['time'] as Timestamp,
    );
  }
}
