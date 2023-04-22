// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA4oKjQx8tnZ6_4SUIGOUwH6OB6CHX-I_s',
    appId: '1:514978136576:web:a763fbb5c7484e3b97cee5',
    messagingSenderId: '514978136576',
    projectId: 'toktok-8da9f',
    authDomain: 'toktok-8da9f.firebaseapp.com',
    storageBucket: 'toktok-8da9f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBw-_ADoMDTBCbGYHw4ICW972DpfQR1VfQ',
    appId: '1:514978136576:android:d1102209abc8c81d97cee5',
    messagingSenderId: '514978136576',
    projectId: 'toktok-8da9f',
    storageBucket: 'toktok-8da9f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC79hOG9iqUZMLzk55X2jBOxNf47QQz49g',
    appId: '1:514978136576:ios:24cb962ce3fad46397cee5',
    messagingSenderId: '514978136576',
    projectId: 'toktok-8da9f',
    storageBucket: 'toktok-8da9f.appspot.com',
    iosClientId: '514978136576-3f4eh16eh8jqk94k925bfja7o390h670.apps.googleusercontent.com',
    iosBundleId: 'com.truonganim.toktok',
  );
}
