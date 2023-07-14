import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String id;
  final String uid;
  final String username;
  final String comment;
  final String profileImage;
  final List likes;
  final Timestamp publicDate;

  Comment({
    required this.id,
    required this.uid,
    required this.username,
    required this.comment,
    required this.profileImage,
    required this.likes,
    required this.publicDate,
  });

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
        id: snapshot['id'],
        uid: snapshot['uid'],
        username: snapshot['username'],
        comment: snapshot['comment'],
        profileImage: snapshot['profileImage'],
        likes: snapshot['likes'],
        publicDate: snapshot['publicDate']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'username': username,
      'comment': comment,
      'profileImage': profileImage,
      'likes': likes,
      'publicDate': publicDate,
    };
  }
}
