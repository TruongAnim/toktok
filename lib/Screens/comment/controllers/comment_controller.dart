import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/controllers/auth_controller.dart';
import 'package:toktok/models/comment.dart';
import 'package:toktok/models/notif.dart';
import 'package:toktok/models/user.dart';
import 'package:toktok/models/video.dart';
import 'package:toktok/services/firebase_messaging_service.dart';

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
        String currentUid = AuthController.instance.user.uid;
        DocumentReference postRef =
            firebaseStore.collection('videos').doc(_postId);
        DocumentSnapshot userDoc =
            await firebaseStore.collection('users').doc(currentUid).get();
        var allComments = await firebaseStore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();
        DocumentReference commentRef = postRef.collection('comments').doc();
        Comment comment = Comment(
          id: commentRef.id,
          uid: AuthController.instance.user.uid,
          username: (userDoc.data() as Map<String, dynamic>)['name'],
          comment: content,
          profileImage:
              (userDoc.data() as Map<String, dynamic>)['profilePhoto'],
          likes: [],
          publicDate: Timestamp.fromDate(DateTime.now()),
        );
        await commentRef.set(comment.toJson());
        await postRef.update({'commentCount': allComments.docs.length + 1});

        createCommentNotification(postRef);
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

  void createCommentNotification(DocumentReference postRef) async {
    Video video = Video.fromSnapshot(await postRef.get());
    AppUser appUser = AuthController.instance.appUser.value;
    Notif notif = Notif(
        id: '',
        uid: video.uid,
        senderId: AuthController.instance.user.uid,
        isRead: false,
        title: '${appUser.name} commented on your video.',
        desc: '',
        type: 'comment',
        videoId: video.id,
        time: DateTime.now().millisecondsSinceEpoch);
    FirebaseMessagingService.instance.sendNotification(notif);
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
