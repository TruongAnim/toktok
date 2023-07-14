import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/controllers/auth_controller.dart';
import 'package:toktok/models/comment.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;

  String _postId = '';

  updatePostId(String id) {
    _postId = id;
    getComments();
  }

  void getComments() {
    _comments.bindStream(firebaseStore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((snap) => Comment.fromSnap(snap)).toList();
    }));
  }

  void postComment(String content) async {
    try {
      content = content.trim();
      if (content.isNotEmpty) {
        DocumentSnapshot userDoc = await firebaseStore
            .collection('users')
            .doc(AuthController.instance.user.uid)
            .get();
        var allComments = await firebaseStore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();
        String commentId = 'Comment ${allComments.docs.length}';
        Comment comment = Comment(
          id: commentId,
          uid: AuthController.instance.user.uid,
          username: (userDoc.data() as Map<String, dynamic>)['name'],
          comment: content,
          profileImage:
              (userDoc.data() as Map<String, dynamic>)['profilePhoto'],
          likes: [],
          publicDate: Timestamp.fromDate(DateTime.now()),
        );
        await firebaseStore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc(commentId)
            .set(comment.toJson());
        await firebaseStore
            .collection('videos')
            .doc(_postId)
            .update({'commentCount': allComments.docs.length + 1});
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Error while commenting !!!',
          message: e.toString(),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void likeComment(String commentId) async {
    String uid = AuthController.instance.user.uid;
    DocumentSnapshot snapshot = await firebaseStore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(commentId)
        .get();
    if (((snapshot.data() as Map<String, dynamic>)['likes'] as List)
        .contains(uid)) {
      await firebaseStore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(commentId)
          .update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await firebaseStore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(commentId)
          .update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }
}
