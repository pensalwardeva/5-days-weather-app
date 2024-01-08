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
        return macos;
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
    apiKey: 'AIzaSyBVqDAiXMjsb628XK8Ub2NAMQFphoTccn0',
    appId: '1:1033111999664:web:c59217f0ecef71b1c65775',
    messagingSenderId: '1033111999664',
    projectId: 'five-d043f',
    authDomain: 'five-d043f.firebaseapp.com',
    storageBucket: 'five-d043f.appspot.com',
    measurementId: 'G-8ZBDRZZ5S1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAWYxm12tIllxRU49LW2_kG9iH1R8vTOO0',
    appId: '1:1033111999664:android:907c49c972367787c65775',
    messagingSenderId: '1033111999664',
    projectId: 'five-d043f',
    storageBucket: 'five-d043f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDnHjnsSLWL7pUowXmBdSLopz_noMUhB6Q',
    appId: '1:1033111999664:ios:b88a370a76394840c65775',
    messagingSenderId: '1033111999664',
    projectId: 'five-d043f',
    storageBucket: 'five-d043f.appspot.com',
    iosBundleId: 'com.example.fiveDaysForecast',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDnHjnsSLWL7pUowXmBdSLopz_noMUhB6Q',
    appId: '1:1033111999664:ios:e4db90e8adbf6b7fc65775',
    messagingSenderId: '1033111999664',
    projectId: 'five-d043f',
    storageBucket: 'five-d043f.appspot.com',
    iosBundleId: 'com.example.fiveDaysForecast.RunnerTests',
  );
}
