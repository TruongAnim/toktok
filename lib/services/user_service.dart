import 'package:firebase_auth/firebase_auth.dart';
import 'package:toktok/constants.dart';

class UserService {
  static final UserService _instance = UserService._();
  static UserService get instance => _instance;
  UserService._();

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  Future<String> getProfilePicture(String uid) async {
    var value = await firebaseStore.collection('users').doc(uid).get();
    return (value.data() as Map<String, dynamic>)['profilePhoto'];
  }
}
