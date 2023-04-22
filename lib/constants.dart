import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:toktok/controllers/auth_controller.dart';

// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStore = FirebaseFirestore.instance;
var firebaseStorage = FirebaseStorage.instance;

// CONTROLLER
var authController = AuthController.instance;
