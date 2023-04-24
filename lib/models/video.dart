import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  final String username;
  final String uid;
  final String id;
  final List likes;
  final int commentCount;
  final int shareCount;
  final String songName;
  final String caption;
  final String videoUrl;
  final String profilePhoto;
  final String thumbnail;
  final String albumPhoto;

  Video({
    required this.username,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.songName,
    required this.caption,
    required this.videoUrl,
    required this.profilePhoto,
    required this.thumbnail,
    required this.albumPhoto,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'uid': uid,
      'id': id,
      'likes': likes,
      'commentCount': commentCount,
      'shareCount': shareCount,
      'songName': songName,
      'caption': caption,
      'videoUrl': videoUrl,
      'profilePhoto': profilePhoto,
      'thumbnail': thumbnail,
      'albumPhoto': albumPhoto,
    };
  }

  static Video fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return Video(
        username: snap['username'],
        uid: snap['uid'],
        id: snap['id'],
        likes: snap['likes'],
        commentCount: snap['commentCount'],
        shareCount: snap['shareCount'],
        songName: snap['songName'],
        caption: snap['caption'],
        videoUrl: //'assets/videos/1.mp4',
            'https://assets.mixkit.co/videos/preview/mixkit-pov-of-a-basket-of-easter-eggs-48595-large.mp4', //snap['videoUrl'],
        profilePhoto: snap['profilePhoto'],
        thumbnail: snap['thumbnail'],
        albumPhoto: snap['albumPhoto']);
  }
}
