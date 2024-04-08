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
    apiKey: 'AIzaSyAR2HRYKEzg9Xm9WO56BqgcTOsL5x0pqvI',
    appId: '1:89131817891:web:6cad5ff9e15bc360581816',
    messagingSenderId: '89131817891',
    projectId: 'tayaresult',
    authDomain: 'tayaresult.firebaseapp.com',
    storageBucket: 'tayaresult.appspot.com',
    measurementId: 'G-KG0V2EVDE4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDVVmu4LMM-g7S39Vr1e0cEqONHUDdNrdg',
    appId: '1:89131817891:android:808eba5d5e5ad4af581816',
    messagingSenderId: '89131817891',
    projectId: 'tayaresult',
    storageBucket: 'tayaresult.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDosfXCmrjCWUZeqpMljAAOXgHILliExeU',
    appId: '1:89131817891:ios:479922c3bd3215b6581816',
    messagingSenderId: '89131817891',
    projectId: 'tayaresult',
    storageBucket: 'tayaresult.appspot.com',
    iosBundleId: 'com.example.tayaResult',
  );
}
