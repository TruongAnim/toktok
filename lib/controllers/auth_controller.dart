import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/constants.dart';
import 'package:toktok/models/user.dart' as Model;

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late String profileTemp;
  late Rx<User?> _currentUser;

  User get user => firebaseAuth.currentUser!;

  @override
  void onReady() {
    super.onReady();
    _currentUser = Rx<User?>(firebaseAuth.currentUser);
    _currentUser.bindStream(firebaseAuth.authStateChanges());
    ever(_currentUser, _setInitialScreen);
  }

  _setInitialScreen(User? callback) {
    final box = GetStorage();
    String? language = box.read('language_selected');
    if (language == null) {
      return;
    }
    if (_currentUser.value == null) {
      Get.offAllNamed(PageRoutes.login);
    } else {
      Get.offAllNamed(PageRoutes.bottomNavigation);
      getProfilePicture();
      print(_currentUser.value!.uid);
    }
  }

  getProfilePicture() {
    print('getProfilePIctrue');
    firebaseStore.collection('users').doc(user.uid).get().then((value) {
      profileTemp = (value.data() as Map<String, dynamic>)['profilePhoto'];
    });
  }

  Future<String> uploadToStorage(File avatar) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(avatar);
    TaskSnapshot snap = await uploadTask;
    String urlImage = await snap.ref.getDownloadURL();
    return urlImage;
  }

  void login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential credential = await firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password);
        print(credential.user!.uid);
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Login fail !!!',
            message: 'Please enter all the field!',
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Login fail !!!',
          message: e.toString(),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void registerUser(String userName, String email, String password) async {
    try {
      if (userName.isNotEmpty && password.isNotEmpty && userName.isNotEmpty) {
        UserCredential credential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        Random random = new Random();
        int randomId = random.nextInt(70);
        String urlAvatar = 'https://i.pravatar.cc/150?img=$randomId';
        Model.User modelUser = Model.User(
            uid: credential.user!.uid,
            name: userName,
            email: email,
            profilePhoto: urlAvatar);
        await firebaseStore
            .collection('users')
            .doc(credential.user!.uid)
            .set(modelUser.toJson());
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Register error!!!',
            message: 'Please enter all the field!',
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Register error!!!',
          message: e.toString(),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
