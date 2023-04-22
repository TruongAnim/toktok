import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String email;
  final String profilePhoto;
  final String uid;

  User(
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

  static User fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return User(
        name: snap['name'],
        email: snap['email'],
        profilePhoto: snap['profilePhoto'],
        uid: snap['uid']);
  }
}
