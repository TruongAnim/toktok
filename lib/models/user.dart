import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String name;
  final String email;
  final String profilePhoto;
  final String description;
  final String fmToken;
  int points;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePhoto,
    required this.description,
    required this.fmToken,
    required this.points,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePhoto': profilePhoto,
      'description': description,
      'fmToken': fmToken,
      'points': points,
    };
  }

  static AppUser fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return AppUser(
      uid: snap['uid'],
      name: snap['name'],
      email: snap['email'],
      profilePhoto: snap['profilePhoto'],
      description: snap['description'],
      fmToken: snap['fmToken'],
      points: snap['points'],
    );
  }

  static AppUser empty() {
    return AppUser(
      uid: 'uid',
      name: 'name',
      email: 'email',
      profilePhoto: 'profilePhoto',
      description: 'description',
      fmToken: 'fmToken',
      points: 0,
    );
  }
}
