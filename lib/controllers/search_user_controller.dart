import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/models/user.dart';

class SearchUserController extends GetxController {
  Rx<List<User>> _listUser = Rx<List<User>>([]);
  List<User> get listUser => _listUser.value;

  searchUser(String query) {
    _listUser.bindStream(
      firebaseStore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .snapshots()
          .map(
        (QuerySnapshot snapshot) {
          return snapshot.docs.map((doc) => User.fromSnapshot(doc)).toList();
        },
      ),
    );
  }
}
