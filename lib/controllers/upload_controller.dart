import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/controllers/auth_controller.dart';
import 'package:toktok/models/notif.dart';
import 'package:toktok/models/user.dart';
import 'package:toktok/models/video.dart';
import 'package:toktok/services/firebase_messaging_service.dart';
import 'package:toktok/services/user_service.dart';
import 'package:toktok/utils/random_utils.dart';
import 'package:toktok/utils/string_utils.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class UploadController extends GetxController {
  Rx<bool> isUploading = Rx<bool>(false);
  RxList<Uint8List> thumbnails = RxList();
  Rx<int> thumbnailIndex = RxInt(0);

  Future<File?> _compressVideo(String videoPath) async {
    final compressed = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.LowQuality, includeAudio: true);
    return compressed!.file;
  }

  void getVideoThumbnails(String videoPath) async {
    for (int i = 0; i < 5; i++) {
      final uint8list = await VideoThumbnail.thumbnailData(
        video: videoPath,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 128,
        quality: 25,
        timeMs: i * 5000,
      );
      if (uint8list != null) {
        thumbnails.add(uint8list);
      }
    }
  }

  Future<File> getUploadThumbnail(String videoPath) async {
    File compressed =
        await VideoCompress.getFileThumbnail(videoPath, quality: 20);
    return compressed;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);
    // UploadTask uploadTask =
    //     ref.putFile((await _compressVideo(videoPath)) as File);
    UploadTask uploadTask = ref.putFile(File(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> _uploadThumbnailToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await getUploadThumbnail(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void getHashtag(String title, String videoId) {
    List<String?> hashtags = StringUtils.getHashTags(title);
    for (String? hashtag in hashtags) {
      if (hashtag != null) {
        hashtag = hashtag.replaceAll('#', '').trim();
        updateHashtag(hashtag, videoId);
      }
    }
  }

  void updateHashtag(String hashtag, String videoId) async {
    DocumentSnapshot snapshot =
        await firebaseStore.collection('hashtags').doc(hashtag).get();
    if (snapshot.exists) {
      firebaseStore.collection('hashtags').doc(hashtag).update({
        'videos': FieldValue.arrayUnion([videoId])
      });
    } else {
      firebaseStore.collection('hashtags').doc(hashtag).set({
        'videos': [videoId],
        'name': hashtag,
      });
    }
  }

  void uploadVideo(String songName, String caption, String videoPath) async {
    isUploading.value = true;
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot snapshot =
          await firebaseStore.collection('users').doc(uid).get();
      DocumentReference videoRef = firebaseStore.collection('videos').doc();
      String videoUrl = await _uploadVideoToStorage(videoRef.id, videoPath);
      String thumbnailUrl =
          await _uploadThumbnailToStorage(videoRef.id, videoPath);
      Video video = Video(
        username: (snapshot.data() as Map<String, dynamic>)['name'],
        uid: uid,
        id: videoRef.id,
        likes: [],
        commentCount: 0,
        viewCount: 0,
        points: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        profilePhoto: (snapshot.data() as Map<String, dynamic>)['profilePhoto'],
        thumbnail: thumbnailUrl,
        albumPhoto: RandomUtils.getRandomImageUrl(),
        publicDate: Timestamp.now(),
      );
      await videoRef.set(video.toJson());
      createNewPostNotification(video);
      isUploading.value = false;
      Get.offAllNamed(PageRoutes.bottomNavigation);
      getHashtag(caption, videoRef.id);
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Upload video fail !!!',
          message: e.toString(),
          duration: const Duration(seconds: 3),
        ),
      );
      isUploading.value = false;
    }
  }

  void createNewPostNotification(Video video) async {
    List<String> followers = await UserService.instance.getFollowers(video.uid);
    AppUser appUser = AuthController.instance.appUser.value;
    for (String follower in followers) {
      Notif notif = Notif(
          id: '',
          uid: follower,
          senderId: video.uid,
          isRead: false,
          title: '${appUser.name} just posted a new video.',
          desc: '',
          type: 'new_post',
          videoId: video.id,
          time: DateTime.now().millisecondsSinceEpoch);
      FirebaseMessagingService.instance.sendNotification(notif);
    }
  }
}
