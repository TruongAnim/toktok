import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/controllers/auth_controller.dart';
import 'package:toktok/models/user.dart';
import 'package:toktok/models/video.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _listUser = Rx<List<User>>([]);
  List<User> get listUser => _listUser.value;
  final Rx<List<Video>> _listVideo = Rx<List<Video>>([]);
  List<Video> get listVideo => _listVideo.value;

  searchUser(String query) {
    _listUser.bindStream(
      firebaseStore
          .collection('users')
          // .where('name', isGreaterThanOrEqualTo: query)
          // .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .snapshots()
          .map(
        (QuerySnapshot snapshot) {
          List<User> temp = [];
          for (QueryDocumentSnapshot item in snapshot.docs) {
            var data = item.data() as Map<String, dynamic>;
            if (data['uid'] != AuthController.instance.user.uid &&
                ((data['name'] as String).toLowerCase().contains(query) ||
                    (data['email'] as String).toLowerCase().contains(query))) {
              temp.add(User.fromSnapshot(item));
            }
          }
          return temp;
        },
      ),
    );
  }

  searchVideo(String query) {
    _listVideo.bindStream(
      firebaseStore
          .collection('videos')
          // .where('caption', isGreaterThanOrEqualTo: query)
          // .where('caption', isLessThanOrEqualTo: query + '\uf8ff')
          .snapshots()
          .map(
        (QuerySnapshot snapshot) {
          List<Video> temp = [];
          for (QueryDocumentSnapshot item in snapshot.docs) {
            var data = item.data() as Map<String, dynamic>;
            if ((data['caption'] as String).toLowerCase().contains(query)) {
              temp.add(Video.fromSnapshot(item));
            }
          }
          return temp;
        },
      ),
    );
  }
}
