import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toktok/models/video.dart';

class Hashtag {
  final String name;
  final List<Video> videos;

  Hashtag({required this.name, required this.videos});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'videos': videos,
    };
  }

  static Hashtag fromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
    return Hashtag(name: data['name'], videos: data['videos']);
  }
}
