import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String name;
  final String email;
  final String profilePhoto;
  final String fmToken;
  final String description;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePhoto,
    required this.fmToken,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePhoto': profilePhoto,
      'fmToken': fmToken,
      'description': description,
    };
  }

  static AppUser fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return AppUser(
      uid: snap['uid'],
      name: snap['name'],
      email: snap['email'],
      profilePhoto: snap['profilePhoto'],
      fmToken: snap['fmToken'],
      description: snap['description'],
    );
  }
}
