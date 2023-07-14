import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String name;
  final String email;
  final String profilePhoto;
  final String uid;

  AppUser(
      {required this.name,
      required this.email,
      required this.profilePhoto,
      required this.uid});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'profilePhoto': profilePhoto,
      'uid': uid
    };
  }

  static AppUser fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return AppUser(
        name: snap['name'],
        email: snap['email'],
        profilePhoto: snap['profilePhoto'],
        uid: snap['uid']);
  }
}
